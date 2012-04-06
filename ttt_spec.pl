:- module(ttt_spec,[assert_row/2,clear_moves/0]).
:- use_module(ttt). 

assert_row(R,P) :-
  ttt:assert(move(point(R,0),P)),
  ttt:assert(move(point(R,1),P)),
  ttt:assert(move(point(R,2),P)).

assert_col(C) :-
  ttt:assert(move(point(0,C),x)),
  ttt:assert(move(point(1,C),x)),
  ttt:assert(move(point(2,C),x)).

assert_diagonal(P) :-
  ttt:assert(move(point(0,0),x)),
  ttt:assert(move(point(1,1),x)),
  ttt:assert(move(point(2,2),x)).

clear_moves :-
  ttt:retractall(move(_,_)).

:- begin_tests(ttt).

test(valid_input) :-
  valid_input(0),
  valid_input(8),
  \+valid_input("hello"),
  \+valid_input(33).

test(valid_inputs) :-
  assert_row(0,o),
  assert_row(1,o),
  valid_inputs(Z),
  [H|T]=Z,
  H=point(2,0),
  length(Z,3).

test(col) :-
  col(point(2,5),point(7,5)),
  \+col(point(2,5),point(2,4)).

test(row) :-
  row(point(2,5),point(2,7)),
  \+row(point(2,5),point(3,5)).



test(number_of_unique) :-
  num_unique([1,1,2,3,3,4,5],N),
  N=5.

test(any) :-
  any(check_length(3),[[1],[1],[1,2,3]]),
  \+any(check_length(9),[[1]]).

test(dumb_cpu) :-
  dumb_cpu_move(Player,move(Point,Player)),
  point(Row,Col)=Point,
  in_valid_range(Row,Col),
  clear_moves.

test(dumb_cpu) :-
  assert_col(0),
  assert_col(1),
  ttt:assert(move(point(0,2),x)),
  ttt:assert(move(point(1,2),x)),
  dumb_cpu_move(Player,move(Point,Player)),
  Point=point(2,2),
  clear_moves.

:-end_tests(ttt).
