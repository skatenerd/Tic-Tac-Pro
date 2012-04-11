:- module(board_utils, [game_over/1, calls/2]).
:- dynamic calls/2.
:- dynamic game_over_probability/1.

game_over(Move_predicate) :-
  assert(calls(game_over, Move_predicate)),
  random(Random),
  game_over_probability(Threshold),
  Random<Threshold.
