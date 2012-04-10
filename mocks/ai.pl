:- module(ai, [smart_cpu_move/2]).
:- dynamic calls/2.

smart_cpu_move(Player, Output) :-
  assert(calls(smart_cpu_move,[Player])),
  Output=move(point(1,1),Player).
