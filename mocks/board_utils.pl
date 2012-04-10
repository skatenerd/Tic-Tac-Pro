:- module(board_utils, [game_over/1]).
:- dynamic calls/2.

game_over(_) :-
  random(Rand),
  Rand>0.5.
