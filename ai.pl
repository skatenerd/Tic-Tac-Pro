:-  module(ai,[other_player/2, smart_cpu_move/2,cache_world/1,cache/1,legal_imagined_move/2, score_world/2,dumb_cpu_move/2]).
:- use_module(board_utils).
:- use_module(library(lists)).
:- use_module(library(assoc)).
:- dynamic imagined_move/2.
:- dynamic cache/1.

prune(1,x).
prune(-1,o).
cache(empty).

other_player(o,Other) :-
  Other=x.

other_player(x,Other) :-
  Other=o.


score_from_current_winner(Score,[x]) :-
  Score=1.

score_from_current_winner(Score,[o]) :-
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
  Naive_score\=0.

move_set(Move_set) :-
  findall(M,real_or_imagined_move(M),Moves),
  list_to_set(Moves,Move_set).

cache_world(Score) :-
  true.
  /*cache(empty), 
  retractall(cache(_)),
  empty_assoc(New_cache),
  assert(cache(New_cache)),
  add_to_cache(Score).

cache_world(Score) :-
  \+cache(empty), 
  add_to_cache(Score).

add_to_cache(Score) :- 
  move_set(Move_set),
  cache(C),
  retractall(cache(_)),
  put_assoc(Move_set,C,Score,New_cache),
  assert(cache(New_cache)).

score_world(Score, Player) :-
  \+cache(empty), 
  cache(C),
  move_set(Move_set),
  get_assoc(Move_set,C,Score),
  write('hit').*/

ai_winner(W) :-
  winner(ai:real_or_imagined_move,W).

score_world(Score,Player) :-
  move_set(Move_set),
  length(Move_set, N),
  N<2,
  Score=0.

score_world(Score, Player) :-
  findall(W,ai_winner(W),Winners),
  list_to_set(Winners,Winner),
  score_from_current_winner(Naive_score,Winner),
  stop_searching(Naive_score),
  Score=Naive_score,
  cache_world(Score).

score_world(Score,Player) :-
  findall(W,ai_winner(W),Winners),
  Winners=[],
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
  list_to_set(C,[Score]),
  retract(imagined_move(H, Player)),
  findall(Scores,recur_or_prune(Score,Scores,T,Player),Scores_coll),
  [Scores|_]=Scores_coll.
  

recur_or_prune(Cur_score, Scores, Moves, Player) :-
  prune(Cur_score,Player),  
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

smart_cpu_move(Player,Move) :-
  score_world(Score,Player),
  score_after_move(Point,Player,Score),
  Move=move(Point,Player). 

score_after_move(Point,Player,Score) :-
  legal_imagined_move(R,C),
  Point=point(R,C),
  assert(imagined_move(Point,Player)),
  other_player(Player,Other),
  score_world(Cur_score, Other),
  retract(imagined_move(Point,Player)),
  Cur_score=Score.
