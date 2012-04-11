:-  module(ai, [unbeatable_cpu_move/2, legal_imagined_move/2, score_world/2]).
:- use_module(board_utils).
:- use_module(game_configuration).
:- use_module(library(lists)).
:- dynamic imagined_move/2.

legal_imagined_move(Row, Col) :-
  board_utils:legal(ai:real_or_imagined_move, [Row, Col]).

real_or_imagined_move(move(Point, Player)) :-
  real_or_imagined_move(Point, Player).

real_or_imagined_move(Point, Player) :-
  ttt:move(Point, Player).

real_or_imagined_move(Point, Player) :-
  imagined_move(Point, Player).

move_set(Moves) :-
  findall(Move, ai:real_or_imagined_move(Move), Moves).

ai_winner(W) :-
  board_utils:winner(ai:real_or_imagined_move, W).

score_from_current_winner(1, [x]).
score_from_current_winner(-1, [o]).
score_from_current_winner(0, []).

prune(Score, player) :-
  score_from_current_winner(Score, [player]).

player_score_pred(o, Pred) :-
  Pred = min_member.

player_score_pred(x, Pred) :-
  Pred = max_member.

score_world(Score, _) :-
  move_set(Move_set),
  length(Move_set, N),
  N<2,
  Score = 0.

score_world(Score, _) :-
  stop_searching,
  findall(Winner, ai_winner(Winner), Winners),
  list_to_set(Winners, Winner_list),
  score_from_current_winner(Naive_score, Winner_list),
  Score = Naive_score.

score_world(Score, Player) :-
  findall(Winner, ai_winner(Winner), Winners),
  Winners = [],
  findall(point(Row, Col), legal_imagined_move(Row, Col), Valid_input_points),
  score_future_boards(Scores, Valid_input_points, Player),
  player_score_pred(Player, Pred),
  call(Pred, Score, Scores).

score_future_boards(Scores, [], _) :-
  Scores = [].

score_future_boards(Scores, Valid_input_points, Player) :-
  Valid_input_points = [Point|Remaining_points],
  assert(imagined_move(Point, Player)),
  game_configuration:other_player(Player, Other),
  findall(Achievable_score, score_world(Achievable_score, Other), Achievable_score_list),
  list_to_set(Achievable_score_list, [Score_after_move]),
  retract(imagined_move(Point, Player)),
  recur_or_prune(Score_after_move, Scores, Remaining_points, Player).

recur_or_prune(Cur_score, Scores, _, Player) :-
  prune(Cur_score, Player),  
  Scores = [Cur_score].

recur_or_prune(Cur_score, Scores, Moves, Player) :-
  score_future_boards(Rest_scores, Moves, Player),
  Scores = [Cur_score|Rest_scores].

stop_searching :-
  board_utils:game_over(ai:real_or_imagined_move).
  
unbeatable_cpu_move(Player, Move) :-
  score_world(Score, Player),
  score_after_move(Point, Player, Score),
  Move = move(Point, Player). 

score_after_move(Point, Player, Score) :-
  legal_imagined_move(R, C),
  Point = point(R, C),
  assert(imagined_move(Point, Player)),
  game_configuration:other_player(Player, Other),
  score_world(Cur_score, Other),
  retract(imagined_move(Point, Player)),
  Cur_score = Score.
