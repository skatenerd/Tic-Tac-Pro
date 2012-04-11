:- module(assertions, [assert_row/2, assert_col/2, assert_diagonal/1, clear_moves/0]).

assert_row(Row,Player) :-
  board:assert(move(point(Row,0),Player)),
  board:assert(move(point(Row,1),Player)),
  board:assert(move(point(Row,2),Player)).

assert_col(Col,Player) :-
  board:assert(move(point(0,Col),Player)),
  board:assert(move(point(1,Col),Player)),
  board:assert(move(point(2,Col),Player)).

assert_diagonal(Player) :-
  board:assert(move(point(0,0),Player)),
  board:assert(move(point(1,1),Player)),
  board:assert(move(point(2,2),Player)).

clear_moves :-
  board:retractall(move(_,_)).
