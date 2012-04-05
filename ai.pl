:-  module(ai,[score_world/1]).
:- dynamic ai_move/2.

score_from_current_winner(Score,[x]) :-
  Score=1.

score_from_current_winner(Score,[o]) :-
  /*fix me*/
  Score = -1.

score_from_current_winner(Score,[]) :-
  false.

score_world(Score) :-
  findall(W,winner(W),Winners),
  score_from_current_winner(Score,Winners).

score_world(Score) :-
  findall(W,winner(W),Winners),
  Winners=[],
  Score=0.
