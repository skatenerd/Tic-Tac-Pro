:- module(ai_spec,[]).
:- use_module(ai).
:- use_module(ttt).
:- use_module(ttt_spec).
:- begin_tests(ai).

test(score_world) :-
  ttt_spec:assert_row(0,x),
  score_world(1,x),
  \+score_world(0,x),
/*  findall(Score, score_world(Score), Scores),
  assertion(Scores=[1]),*/
  ttt_spec:clear_moves.

test(score_world) :-
  ttt_spec:assert_row(0,o),
  findall(Score, score_world(Score,o), Scores),
  assertion(Scores=[-1]),
  ttt_spec:clear_moves.

test(score_world) :-
  findall(Score, score_world(Score,x), Scores),
  assertion(Scores=[0]).


test(imminent_victories) :-
  ttt:assert(move(point(0,0),o)),
  ttt:assert(move(point(0,1),o)),
  findall(Score, score_world(Score,o), Scores),
  assertion(Scores=[-1]).


:- end_tests(ai).
