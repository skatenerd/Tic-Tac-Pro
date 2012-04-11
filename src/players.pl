:- module(players, [turn/2]).
:- use_module(ai).
:- use_module(board).
:- use_module(io).

turn(human, Alias) :-
  io:get_move_input(Alias,[Row,Col]),nl,
  board:assert(move(point(Row,Col),Alias)).

turn(cpu, Alias) :-
  ai:unbeatable_cpu_move(Alias,Cpu_move),
  board:assert(Cpu_move).
