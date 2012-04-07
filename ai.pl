:-  module(ai,[legal_imagined_move/2, score_world/2,dumb_cpu_move/2]).
:- use_module(board_utils).

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

score_world(Score, Player) :-
  findall(W,ai_winner(W),Winners),
  score_from_current_winner(Naive_score,Winners),
  stop_searching(Naive_score),
  Score=Naive_score.

score_world(Score,Player) :-
  findall(W, ai_winner(W), Winners),
  Winners=[],
  findall(point(R,C),legal_imagined_move(R,C),Valid_input_points),
  length(Valid_input_points,N),
  score_future_boards(Scores, Valid_input_points, Player),
  player_score_pred(Player, Pred),
  call(Pred, Score, Scores).

score_future_boards(Scores, [], Player) :-
  Scores=[].

score_future_boards(Scores, [H|T], Player) :-
  assert(move(H, Player)),
  /*findall(W, ai_winner(W), Winners),
  score_from_current_winner(Score, Winners),*/
  other_player(Player,Other),
  score_world(Score, Other),
  retract(move(H, Player)),
  score_future_boards(Rest_scores, T, Player),
  Scores=[Score|Rest_scores].
  

real_or_imagined_move(Point, Player) :-
  move(Point, Player).

real_or_imagined_move(Point, Player) :-
  ttt:move(Point, Player).

legal_imagined_move(Row,Col) :-
  board_utils:legal(ai:real_or_imagined_move,[Row,Col]).



dumb_cpu_move(Player,Move) :-
  repeat,
  random(0,3,Row),
  random(0,3,Col),
  board_utils:legal(ttt:move,[Row,Col]),
  Move=move(point(Row,Col),Player).
