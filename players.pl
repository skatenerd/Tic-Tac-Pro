:- module(players, [turn/2]).
:- use_module(io).
:- use_module(ai).
:- use_module(ttt).

turn(human, Alias) :-
  get_input(Alias,[Row,Col]),nl,
  ttt:assert(move(point(Row,Col),Alias)).

turn(cpu, Alias) :-
  smart_cpu_move(Alias,Cpu_move),
  ttt:assert(Cpu_move).
