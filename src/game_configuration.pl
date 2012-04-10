:- module(game_configuration, [other_player/2, cleanup/0, move_source/2]).
:- dynamic move_source/2.

cleanup :-
  retractall(move_source(_,_)).

other_player(o,Other) :-
  Other = x.

other_player(x,Other) :-
  Other = o.
