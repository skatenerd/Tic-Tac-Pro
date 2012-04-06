:-  module(ai,[score_world/2]).
:- dynamic ai_move/2.

score_from_current_winner(Score,[x|_]) :-
  Score=1.

score_from_current_winner(Score,[o|_]) :-
  /*fix me*/
  Score = -1.

score_from_current_winner(Score,[]) :-
  Score = 0.

player_score_pred(o,Pred) :-
  Pred=min_member.

player_score_pred(x,Pred) :-
  Pred=max_member.

score_world(Score, Player) :-
  findall(W,ai_winner(W),Winners),
  score_from_current_winner(Zzzzz,Winners),
  \+Zzzzz=0,
  Score=Zzzzz.

score_world(Score,Player) :-
  findall(W, ai_winner(W), Winners),
  Winners=[],
  valid_inputs(Valid_inputs),
  score_future_boards(Scores, Valid_inputs, Player),
  player_score_pred(Player, Goal),
  call(Goal, Score, Scores).

score_future_boards(Scores, [], Player) :-
  Scores=[].

score_future_boards(Scores, [H|T], Player) :-
  assert(move(H, Player)),
  findall(W, ai_winner(W), Winners),
  score_from_current_winner(Score, Winners),
  /*score_world(Score, Player),*/
  retract(move(H, Player)),
  score_future_boards(Rest_scores, T, Player),
  Scores=[Score|Rest_scores].
  

real_or_imagined_move(Point, Player) :-
  move(Point, Player).
real_or_imagined_move(Point, Player) :-
  ttt:move(Point, Player).
