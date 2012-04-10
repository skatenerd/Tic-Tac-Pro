:- module(players_spec, []).
:- use_module(players).
:- begin_tests(players).
:- load_files('mocks/ai.pl',[redefine_module(true)]).
:- load_files('mocks/io.pl',[redefine_module(true)]).
:- load_files('mocks/ttt.pl',[redefine_module(true)]).

test(human_turn,
     [cleanup(ttt:retractall(move(_,_)))]) :-
  turn(human, x),
  io:calls(get_move_input,x),
  ttt:move(_,_).

test(cpu_turn,
     [cleanup(ttt:retractall(move(_,_)))]) :-
  turn(cpu, o),
  ai:calls(smart_cpu_move,o),
  ttt:move(_,_).
  /*ttt:retractall(move(_,_)).*/

:- unload_file('/mocks/io.pl').
:- unload_file('mocks/ttt.pl').
:- unload_file('mocks/ai.pl').
:- end_tests(players).
