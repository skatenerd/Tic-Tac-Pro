:- module(ai_spec, []).
:- use_module(assertions).
:- use_module(src/board).
:- use_module(src/ai).
:- use_module(library(lists)).

cleanup :-
  ai:retractall(imagined_move(_, _)),
  assertions:clear_moves.

:- begin_tests(ai).

test(unbeatable_cpu,
     [cleanup(cleanup)]) :-
  board:assert(move(point(0, 0), x)),
  board:assert(move(point(0, 1), x)),
  board:assert(move(point(1, 0), o)),
  board:assert(move(point(1, 1), o)),
  unbeatable_cpu_move(x, move(Point, _)),
  Point = point(0, 2).

test(unbeatable_cpu,
     [cleanup(cleanup)]) :-
  board:assert(move(point(0, 0), x)),
  board:assert(move(point(1, 0), o)),
  unbeatable_cpu_move(x, move(Point, _)),
  assertion(Point = point(0, _)).

test(legal_imagined_moves,
     [cleanup(cleanup)]) :-
  assertions:assert_row(0, o),
  ai:assert(imagined_move(point(2, 2), x)),
  legal_imagined_move(2, 0),
  \+legal_imagined_move(0, 0),
  \+legal_imagined_move(2, 2),
  findall(point(R, C), legal_imagined_move(R, C), [H|_]),
  H = point(1, 0).

test(x_already_won,
     [cleanup(cleanup)]) :-
  assertions:assert_row(0, x),
  board:assert(move(point(1, 0), o)),
  board:assert(move(point(1, 1), o)),
  assertion(score_world(1, x)).

test(o_already_won,
     [cleanup(cleanup)]) :-
  assertions:assert_row(0, o),
  board:assert(move(point(1, 0), x)),
  board:assert(move(point(1, 1), x)),
  assertion(score_world(-1, x)).

test(inevitable_tie,
     [cleanup(cleanup)]) :-
  board:assert(move(point(0, 0), x)),
  board:assert(move(point(0, 1), o)),
  board:assert(move(point(0, 2), x)),
  board:assert(move(point(1, 0), o)),
  board:assert(move(point(1, 1), x)),
  board:assert(move(point(1, 2), o)),
  board:assert(move(point(2, 0), o)),
  board:assert(move(point(2, 1), x)),
  assertion(score_world(0, o)),
  assertion(\+score_world(1, o)).

test(nearly_empty,
     [cleanup(cleanup)]) :-
  board:assert(move(point(0, 0), x)),
  assertion(score_world(0, o)).

test(nearly_empty,
     [cleanup(cleanup)]) :-
  board:assert(move(point(0, 0), x)),
  board:assert(move(point(1, 1), o)),
  assertion(score_world(0, x)).

test(imminent_o_victory,
     [cleanup(cleanup)]) :-
  board:assert(move(point(0, 0), o)),
  board:assert(move(point(0, 1), x)),
  board:assert(move(point(1, 0), o)),
  board:assert(move(point(1, 1), x)),
  board:assert(move(point(1, 2), x)),
  board:assert(move(point(2, 1), o)),
  board:assert(move(point(2, 2), x)),
  assertion(score_world(-1, o)).

test(imminent_x_victory,
     [cleanup(cleanup)]) :-
  board:assert(move(point(0, 0), x)),
  board:assert(move(point(1, 1), x)),
  board:assert(move(point(2, 0), x)),
  board:assert(move(point(2, 1), o)),
  board:assert(move(point(2, 2), o)),
  assertion(score_world(1, o)).

test(imminent_x_victory,
     [cleanup(cleanup)]) :-
  board:assert(move(point(0, 0), x)),
  board:assert(move(point(1, 1), x)),
  board:assert(move(point(2, 1), o)),
  board:assert(move(point(2, 2), o)),
  assertion(score_world(1, x)).

test(distant_victory,
     [cleanup(cleanup)]) :-
  board:assert(move(point(0, 0), x)),
  board:assert(move(point(2, 2), x)),
  board:assert(move(point(2, 0), o)),
  assertion(score_world(1, o)),
  assertion(\+score_world(0, o)).

test(distant_victory,
     [cleanup(cleanup)]) :-
  board:assert(move(point(0, 0), x)),
  board:assert(move(point(0, 2), o)),
  assertion(score_world(1, x)).


:- end_tests(ai).
