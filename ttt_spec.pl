:- use_module(ttt). 
:- begin_tests(all).

assert_row(R) :-
  assert_moves([move(point(R,0),x),
                move(point(R,1),x),
                move(point(R,2),x)]).

assert_col(C) :-
  assert_moves([move(point(0,C),x),
                move(point(1,C),x),
                move(point(2,C),x)]).

assert_diagonal(_) :-
  assert_moves([move(point(0,0),x),
                move(point(1,1),x),
                move(point(2,2),x)]).

test(corner) :-
  corner(0,0),
  \+corner(2,7).

test(col) :-
  col(point(2,5),point(7,5)),
  \+col(point(2,5),point(2,4)).

test(row) :-
  row(point(2,5),point(2,7)),
  \+row(point(2,5),point(3,5)).

test(in_bounds) :-
  in_bounds(point(2,2)),
  \+in_bounds(point(99,84)).

test(row_detection) :-
  assert_row(2),
  findall(W,winner(W),Winners),
  member(x,Winners),
  clear_moves.

test(col_detection) :-
  assert_col(0),
  findall(W,winner(W),Winners),
  member(x,Winners),
  clear_moves.

test(dagonal_detection) :-
  assert_diagonal(55),
  findall(W,winner(W),Winners),
  member(x,Winners),
  clear_moves.

test(number_of_unique) :-
  num_unique([1,1,2,3,3,4,5],N),
  N=5.

test(any) :-
  any(check_length(3),[[1],[1],[1,2,3]]),
  \+any(check_length(9),[[1]]).

test(dumb_cpu) :-
  dumb_cpu_move(Player,move(Point,Player)),
  in_bounds(Point).

test(dumb_cpu) :-
  assert_col(0),
  assert_col(1),
  assert_moves([move(point(0,2),x),move(point(1,2),x)]),
  dumb_cpu_move(Player,move(Point,Player)),
  Point=point(2,2),
  clear_moves.

:-end_tests(all).
