:- module(game_configuration, [other_player/2, move_source/2, configure/1]).
:- dynamic move_source/2.

cleanup :-
  retractall(move_source(_,_)).

other_player(o,Other) :-
  Other = x.

other_player(x,Other) :-
  Other = o.

configure(true) :-
  game_configuration:assert(move_source(x, human)),
  game_configuration:assert(move_source(o, cpu)).

configure(false) :-
  game_configuration:assert(move_source(x, cpu)),
  game_configuration:assert(move_source(o, human)).

