:- module(players, [turn/2]).
:- dynamic calls/2.

turn(Move_source, Alias) :-
  write(Move_source),
  write(Alias),
  assert(calls(turn,[Move_source,Alias])).
