:- module(players, [turn/2]).
:- dynamic calls/2.

turn(Move_source, Alias) :-
  assert(calls(turn,[Move_source,Alias])).
