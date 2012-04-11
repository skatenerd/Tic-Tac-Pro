:- module(io, [get_move_input/2, farewell/0]).
:- dynamic calls/2.

get_move_input(Alias, Input) :-
  Input=[1,1],
  assert(calls(get_move_input,Alias)).

farewell :-
  assert(calls(farewell,_)).
