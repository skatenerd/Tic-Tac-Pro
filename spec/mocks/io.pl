:- module(io, [get_move_input/2, calls/2]).
:- dynamic calls/2.

get_move_input(Alias, Input) :-
  Input=[1,1],
  assert(calls(get_move_input,Alias)).
