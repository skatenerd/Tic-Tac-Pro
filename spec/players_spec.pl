:- module(players_spec, []).
:- begin_tests(players).
:- use_module(src/players).
:- load_files('spec/mocks/ai.pl',[redefine_module(true)]).
:- load_files('spec/mocks/io.pl',[redefine_module(true)]).
:- load_files('spec/mocks/ttt.pl',[redefine_module(true)]).

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

:- unload_file('spec/mocks/io.pl').
:- unload_file('spec/mocks/ttt.pl').
:- unload_file('spec/mocks/ai.pl').
:- end_tests(players).
