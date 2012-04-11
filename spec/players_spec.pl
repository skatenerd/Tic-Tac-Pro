:- module(players_spec, []).

cleanup_assertions :-
  ttt:retractall(move(_,_)),
  io:retractall(calls(_,_)).


:- begin_tests(players).
:- use_module(src/players).

test(setup) :-
  load_files('spec/mocks/ai.pl',[redefine_module(true)]),
  load_files('spec/mocks/io.pl',[redefine_module(true)]).

test(human_turn,
     [cleanup(cleanup_assertions)]) :-
  turn(human, x),
  io:calls(get_move_input,x),
  ttt:move(_,_).

test(cpu_turn,
     [cleanup(cleanup_assertions)]) :-
  turn(cpu, o),
  ai:calls(unbeatable_cpu_move,o),
  ttt:move(_,_).

test(cleanup) :-
  load_files('src/io.pl',[redefine_module(true)]),
  load_files('src/ai.pl',[redefine_module(true)]).

:- end_tests(players).
