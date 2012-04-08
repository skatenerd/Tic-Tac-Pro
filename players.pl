:- module(players, [turn/1]).
:- use_module(io).
:- use_module(ai).

turn(human) :-
  write('the board is: '),
  nl,
  print_board, 
  io:get_input([Row,Col]),
  nl,
  ttt:assert(move(point(Row,Col),x)).

turn(cpu) :-
  ai:smart_cpu_move(o,Cpu_move),
  ttt:assert(Cpu_move).
