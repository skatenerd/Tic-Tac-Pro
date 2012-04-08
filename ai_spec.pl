:- module(ai_spec,[]).
:- use_module(ai).
:- use_module(ttt).
:- use_module(ttt_spec).
:- use_module(library(lists)).

cleanup :-
  ai:retractall(imagined_move(_,_)),
  ttt_spec:clear_moves,
  ai:retractall(cache(_)),
  ai:assert(cache(empty)).

:- begin_tests(ai).

test(smart_cpu,
     [cleanup(cleanup)]) :-
  ttt:assert(move(point(0,0),x)),
  ttt:assert(move(point(0,1),x)),
  ttt:assert(move(point(1,0),o)),
  ttt:assert(move(point(1,1),o)),
  smart_cpu_move(x,move(Point,Player)),
  write(Point),
  Point=point(0,2).

test(smart_cpu,
     [cleanup(cleanup)]) :-
  ttt:assert(move(point(0,0),x)),
  ttt:assert(move(point(1,0),o)),
  smart_cpu_move(x,move(Point,Player)),
  write(Point),
  assertion(Point=point(0,_)).

test(dumb_cpu) :-
  dumb_cpu_move(o,move(Point,Player)),
  point(Row,Col)=Point,
  board_utils:in_valid_range(Row,Col).
/*
test(add_to_cache,
     [cleanup(cleanup)]) :-
  ttt:assert(move(point(0,0),x)),
  cache_world(0),
  ai:cache(C),
  get_assoc([move(point(0,0),x)],C,0).*/

test(dumb_cpu,
     [cleanup(cleanup)]) :-
  ttt_spec:assert_row(0,o),
  ttt_spec:assert_row(1,o),
  ttt:assert(move(point(0,2),x)),
  ttt:assert(move(point(1,2),x)),
  dumb_cpu_move(o,move(Point,o)),
  Point=point(2,2).

test(legal_imagined_moves,
     [cleanup(cleanup)]) :-
  ttt_spec:assert_row(0,o),
  ai:assert(imagined_move(point(2,2),x)),
  legal_imagined_move(2,0),
  \+legal_imagined_move(0,0),
  \+legal_imagined_move(2,2),
  findall(point(R,C),legal_imagined_move(R,C),[H|T]),
  H=point(1,0).

test(x_already_won,
     [cleanup(cleanup)]) :-
  ttt_spec:assert_row(0,x),
  ttt:assert(move(point(1,0),o)),
  ttt:assert(move(point(1,1),o)),
  assertion(score_world(1,x)).

test(o_already_won,
     [cleanup(cleanup)]) :-
  ttt_spec:assert_row(0,o),
  ttt:assert(move(point(1,0),x)),
  ttt:assert(move(point(1,1),x)),
  assertion(score_world(-1,x)).

test(inevitable_tie,
     [cleanup(cleanup)]) :-
  ttt:assert(move(point(0,0),x)),
  ttt:assert(move(point(0,1),o)),
  ttt:assert(move(point(0,2),x)),
  ttt:assert(move(point(1,0),o)),
  ttt:assert(move(point(1,1),x)),
  ttt:assert(move(point(1,2),o)),
  ttt:assert(move(point(2,0),o)),
  ttt:assert(move(point(2,1),x)),
  assertion(score_world(0,o)),
  assertion(\+score_world(1,o)).

test(nearly_empty,
     [cleanup(cleanup)]) :-
  ttt:assert(move(point(0,0),x)),
  assertion(score_world(0,o)).

test(nearly_empty,
     [cleanup(cleanup)]) :-
  ttt:assert(move(point(0,0),x)),
  ttt:assert(move(point(1,1),o)),
  assertion(score_world(0,x)).

test(imminent_o_victory,
     [cleanup(cleanup)]) :-
  ttt:assert(move(point(0,0),o)),
  ttt:assert(move(point(0,1),x)),
  ttt:assert(move(point(1,0),o)),
  ttt:assert(move(point(1,1),x)),
  ttt:assert(move(point(1,2),x)),
  ttt:assert(move(point(2,1),o)),
  ttt:assert(move(point(2,2),x)),
  assertion(score_world(-1,o)).

test(imminent_x_victory,
     [cleanup(cleanup)]) :-
  ttt:assert(move(point(0,0),x)),
  ttt:assert(move(point(0,1),x)),
  ttt:assert(move(point(1,0),o)),
  ttt:assert(move(point(1,1),x)),
  ttt:assert(move(point(1,2),o)),
  ttt:assert(move(point(2,0),x)),
  ttt:assert(move(point(2,1),o)),
  ttt:assert(move(point(2,2),o)),
  assertion(score_world(1,x)).

test(imminent_x_victory,
     [cleanup(cleanup)]) :-
  ttt:assert(move(point(0,0),x)),
  ttt:assert(move(point(1,1),x)),
  ttt:assert(move(point(2,0),x)),
  ttt:assert(move(point(2,1),o)),
  ttt:assert(move(point(2,2),o)),
  assertion(score_world(1,o)).

test(imminent_x_victory,
     [cleanup(cleanup)]) :-
  ttt:assert(move(point(0,0),x)),
  ttt:assert(move(point(1,1),x)),
  ttt:assert(move(point(2,1),o)),
  ttt:assert(move(point(2,2),o)),
  assertion(score_world(1,x)).

test(intelligent_victory,
     [cleanup(cleanup)]) :-
  ttt:assert(move(point(0,0),x)),
  ttt:assert(move(point(2,2),x)),
  ttt:assert(move(point(2,0),o)),
  assertion(score_world(1,o)),
  assertion(\+score_world(0,o)).

test(distant_victories,
     [cleanup(cleanup)]) :-
  ttt:assert(move(point(0,0),x)),
  ttt:assert(move(point(0,2),o)),
  assertion(score_world(1,x)).


:- end_tests(ai).
