:- module(ai_spec,[]).
:- use_module(ai).
:- use_module(ttt).
:- use_module(ttt_spec).
:- begin_tests(ai).

test(x_already_won,
     [cleanup(ttt_spec:clear_moves)]) :-
  ttt_spec:assert_row(0,x),
  score_world(1,x),
  \+score_world(0,x),
  findall(Score, score_world(Score,o), Scores),
  assertion(Scores=[1]).

test(o_already_won,
     [cleanup(ttt_spec:clear_moves)]) :-
  ttt_spec:assert_row(0,o),
  findall(Score, score_world(Score,o), Scores),
  assertion(Scores=[-1]).

test(inevitable_tie,
     [cleanup(ttt_spec:clear_moves)]) :-
  ttt:assert(move(point(0,0),x)),
  ttt:assert(move(point(0,1),x)),
  ttt:assert(move(point(0,2),o)),
  ttt:assert(move(point(1,0),x)),
  ttt:assert(move(point(1,1),o)),
  ttt:assert(move(point(1,2),o)),
  ttt:assert(move(point(2,0),o)),
  ttt:assert(move(point(2,1),o)),
  assertion(score_world(0,x)).

test(score_empty) :-
  findall(Score, score_world(Score,x), Scores),
  assertion(Scores=[0]),
  assertion(score_world(0,x)).


test(imminent_victories, 
     [cleanup(ttt_spec:clear_moves)]) :-
  ttt:assert(move(point(0,0),o)),
  ttt:assert(move(point(0,1),o)),
  findall(Score, score_world(Score,o), Scores),
  assertion(Scores=[-1]).

test(imminent_victories,
     [cleanup(ttt_spec:clear_moves)]) :-
  ttt:assert(move(point(0,0),x)),
  ttt:assert(move(point(0,1),x)),
  findall(Score, score_world(Score,x), Scores),
  assertion(Scores=[1]).
/*
test(distant_victories,
     [cleanup(ttt_spec:clear_moves)]) :-
  ttt:assert(move(point(0,0),x)),
  ttt:assert(move(point(0,2),x)),
  ttt:assert(move(point(2,2),x)),
  ttt:assert(move(point(1,1),o)),
  findall(Score, score_world(Score,o), Scores),
  assertion(Scores=[1]),
  assertion(score_world(1,o)).
 */ 



:- end_tests(ai).
