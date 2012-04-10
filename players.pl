:- module(players, [turn/1]).
:- ensure_loaded(io).
:- ensure_loaded(ai).
:- ensure_loaded(ttt).

turn(human) :-
  write('the board is: '),
  nl,
  print_board, 
  get_input([Row,Col]),
  nl,
  ttt:assert(move(point(Row,Col),x)).

turn(cpu) :-
  smart_cpu_move(o,Cpu_move),
  ttt:assert(Cpu_move).
