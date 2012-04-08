:- module(ttt_spec,[assert_row/2,clear_moves/0]).
:- use_module(ttt). 

assert_row(R,P) :-
  ttt:assert(move(point(R,0),P)),
  ttt:assert(move(point(R,1),P)),
  ttt:assert(move(point(R,2),P)).

assert_col(C,P) :-
  ttt:assert(move(point(0,C),P)),
  ttt:assert(move(point(1,C),P)),
  ttt:assert(move(point(2,C),P)).

assert_diagonal(P) :-
  ttt:assert(move(point(0,0),P)),
  ttt:assert(move(point(1,1),P)),
  ttt:assert(move(point(2,2),P)).

clear_moves :-
  ttt:retractall(move(_,_)).

:- begin_tests(ttt).

test(valid_input) :-
  valid_input(0),
  valid_input(8),
  \+valid_input("hello"),
  \+valid_input(33).

:-end_tests(ttt).
