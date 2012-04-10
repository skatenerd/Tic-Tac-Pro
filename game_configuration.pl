:- module(game_configuration, [other_player/2]).
:- dynamic move_source/2.

other_player(o,Other) :-
  Other = x.

other_player(x,Other) :-
  Other = o.
