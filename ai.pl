:-  module(ai,[cache_world/1,cache/2,legal_imagined_move/2, score_world/2,dumb_cpu_move/2]).
:- use_module(board_utils).
:- use_module(library(lists)).
:- dynamic imagined_move/2.
:- dynamic cache/2.

prune(1,x).
prune(-1,o).

other_player(o,Other) :-
  Other=x.

other_player(x,Other) :-
  Other=o.


score_from_current_winner(Score,[x|_]) :-
  Score=1.

score_from_current_winner(Score,[o|_]) :-
  Score = -1.

score_from_current_winner(Score,[]) :-
  Score = 0.

player_score_pred(o,Pred) :-
  Pred=min_member.

player_score_pred(x,Pred) :-
  Pred=max_member.

stop_searching(_) :-
  board_full(ai:real_or_imagined_move).

stop_searching(Naive_score) :-
  \+Naive_score=0.

move_set(Move_set) :-
  findall(M,real_or_imagined_move(M),Moves),
  list_to_set(Moves,Move_set).

cache_world(Score) :-
  move_set(Move_set),
  assert(cache(Move_set,Score)).

score_world(Score, Player) :-
  move_set(Move_set),
  findall(C,cache(Move_set,C),Cs),
  length(Cs,N),
  N>0,
  [Z|T]=Cs,
  Score=Z.

score_world(Score, Player) :-
  findall(W,ai_winner(W),Winners),
  score_from_current_winner(Naive_score,Winners),
  stop_searching(Naive_score),
  Score=Naive_score,
  cache_world(Score).

score_world(Score,Player) :-
  findall(point(R,C),legal_imagined_move(R,C),Valid_input_points),
  score_future_boards(Scores, Valid_input_points, Player),
  player_score_pred(Player, Pred),
  call(Pred, Score, Scores),
  cache_world(Score).

score_future_boards(Scores, [], Player) :-
  Scores=[].

score_future_boards(Scores, [H|T], Player) :-
  assert(imagined_move(H, Player)),
  other_player(Player,Other),
  findall(S,score_world(S, Other),C),
  [Score|_]=C,
  retract(imagined_move(H, Player)),
  recur_or_prune(Score, Scores, T, Player).

recur_or_prune(Cur_score, Scores, Moves, Player) :-
  prune(Score,Player),  
  Scores=[Cur_score].

recur_or_prune(Cur_score, Scores, Moves, Player) :-
  score_future_boards(Rest_scores, Moves, Player),
  Scores=[Cur_score|Rest_scores].
  
real_or_imagined_move(move(Point,Player)) :-
  real_or_imagined_move(Point,Player).

real_or_imagined_move(Point, Player) :-
  ttt:move(Point, Player).

real_or_imagined_move(Point, Player) :-
  imagined_move(Point, Player).

legal_imagined_move(Row,Col) :-
  board_utils:legal(ai:real_or_imagined_move,[Row,Col]).

dumb_cpu_move(Player,Move) :-
  repeat,
  random(0,3,Row),
  random(0,3,Col),
  board_utils:legal(ttt:move,[Row,Col]),
  Move=move(point(Row,Col),Player).
