:-  module(ai,[score_world/2]).
:- dynamic ai_move/2.

score_from_current_winner(Score,[x|_]) :-
  Score=1.

score_from_current_winner(Score,[o|_]) :-
  /*fix me*/
  Score = -1.

score_from_current_winner(Score,[]) :-
  Score = 0.

score_world(Score,Player) :-
  findall(W,ai_winner(W),Winners),
  score_from_current_winner(Score,Winners),
  \+Score=0.

score_world(Score,Player) :-
  findall(W,ai_winner(W),Winners),
  Winners=[],
  valid_inputs(Valid_inputs),
  score_future_boards(Scores,Valid_inputs,Player).

score_future_boards(Scores, [],Player) :-
  Scores=[].

score_future_boards(Scores,[H|T],Player) :-
  assert(move(H,Player)),
  findall(W,ai_winner(W),Winners),
  score_from_current_winner(Cur_score,Winners),
  retract(move(H,Player)),
  score_future_boards(Rest_scores,T,Player),
  Scores=[Cur_score|Rest_scores].

real_or_imagined_move(Point,Player) :-
  move(Point,Player).
real_or_imagined_move(Point,Player) :-
  ttt:move(Point,Player).
