:- use_module(ttt). 
:- begin_tests(all).

assert_moves([]) :-
  true.
assert_moves([H|T]) :-
  assert(H),
  assert_moves(T).

assert_row(_) :-
  assert_moves([move(point(2,0),x),
                move(point(2,1),x),
                move(point(2,2),x)]).

assert_col(_) :-
  assert_moves([move(point(0,0),x),
                move(point(1,0),x),
                move(point(2,0),x)]).

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
  assert_row(55),
  findall(W,winner(W),Winners),
  member(x,Winners),
  retractall(move(_,_)).

test(col_detection) :-
  assert_col(55),
  findall(W,winner(W),Winners),
  member(x,Winners),
  retractall(move(_,_)).

test(dagonal_detection) :-
  assert_diagonal(55),
  findall(W,winner(W),Winners),
  member(x,Winners),
  retractall(move(_,_)).
  
test(number_of_unique) :-
  num_unique([1,1,2,3,3,4,5],N),
  N=5.
  
/*test(row_detection,
     [setup(assert_row(_)),
      cleanup(retractall(point(_,_)))]) :-
  write('---------'),
  write('---------').*/

:-end_tests(all).
