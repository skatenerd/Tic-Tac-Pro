:- module(ai, [unbeatable_cpu_move/2]).
:- dynamic calls/2.

unbeatable_cpu_move(Player, Output) :-
  assert(calls(unbeatable_cpu_move,Player)),
  Output=move(point(1,1),Player).
