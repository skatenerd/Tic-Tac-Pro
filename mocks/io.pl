:- module(io, [print_board/0, get_input/1, calls/2]).
:- dynamic calls/2.

get_input(Input) :-
  Input=[1,1].

print_board :-
  assert(calls(print_board,[])),
  true.
