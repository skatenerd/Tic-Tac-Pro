:- module(assertions, [assert_row/2, assert_col/2, assert_diagonal/1, clear_moves/0]).

assert_row(Row,Player) :-
  ttt:assert(move(point(Row,0),Player)),
  ttt:assert(move(point(Row,1),Player)),
  ttt:assert(move(point(Row,2),Player)).

assert_col(Col,Player) :-
  ttt:assert(move(point(0,Col),Player)),
  ttt:assert(move(point(1,Col),Player)),
  ttt:assert(move(point(2,Col),Player)).

assert_diagonal(Player) :-
  ttt:assert(move(point(0,0),Player)),
  ttt:assert(move(point(1,1),Player)),
  ttt:assert(move(point(2,2),Player)).

clear_moves :-
  ttt:retractall(move(_,_)).
