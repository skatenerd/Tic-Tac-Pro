:- use_module(ttt). 
:- begin_tests(all).

assert_row(R) :-
  ttt:assert(move(point(R,0),x)),
  ttt:assert(move(point(R,1),x)),
  ttt:assert(move(point(R,2),x)).

assert_col(C) :-
  ttt:assert(move(point(0,C),x)),
  ttt:assert(move(point(1,C),x)),
  ttt:assert(move(point(2,C),x)).

assert_diagonal :-
  ttt:assert(move(point(0,0),x)),
  ttt:assert(move(point(1,1),x)),
  ttt:assert(move(point(2,2),x)).

clear_moves :-
  ttt:retractall(move(_,_)).

test(valid_input) :-
  valid_input(0),
  valid_input(8),
  \+valid_input("hello"),
  \+valid_input(33).

test(get_input) :-
  see('input.txt'),
  get_input(I),
  I=[1,0],
  see(user_input).

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
  assert_diagonal,
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

test(printing) :-
  assert_row(0),
  with_output_to(codes(Codes),print_board),
  format("~s",[Codes]),
  assertion(Codes="x|x|x\n_|_|_\n_|_|_\n"),
  clear_moves.

test(dumb_cpu) :-
  assert_col(0),
  assert_col(1),
  ttt:assert(move(point(0,2),x)),
  ttt:assert(move(point(1,2),x)),
  dumb_cpu_move(Player,move(Point,Player)),
  Point=point(2,2),
  clear_moves.

:-end_tests(all).
