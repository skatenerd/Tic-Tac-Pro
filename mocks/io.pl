:- module(io, [get_input/2, calls/2]).
:- dynamic calls/2.

get_input(Alias, Input) :-
  Input=[1,1],
  assert(calls(get_input,Alias)).
