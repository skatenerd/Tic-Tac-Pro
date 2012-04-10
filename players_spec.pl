:- module(players_spec, []).
:- use_module(players).
:- begin_tests(players).
:- load_files('mocks/ai.pl',[redefine_module(true)]).
:- load_files('mocks/io.pl',[redefine_module(true)]).
:- load_files('mocks/ttt.pl',[redefine_module(true)]).

test(human_turn) :-
  turn(human, x),
  io:calls(get_input,x),
  io:get_input(_,[Row,Col]),
  ttt:move(point(Row,Col),_),
  ttt:retractall(move(_,_)).

test(cpu_turn) :-
  turn(cpu, o),
  ai:calls(smart_cpu_move,_),
  ai:smart_cpu_move(_,move(point(Row,Col),_)),
  ttt:move(point(Row,Col),_),
  ttt:retractall(move(_,_)).

:- unload_file('/mocks/io.pl').
:- unload_file('mocks/ttt.pl').
:- unload_file('mocks/ai.pl').
:- end_tests(players).
