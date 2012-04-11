:- module(game_configuration_spec, []).
:- use_module(src/game_configuration).
:- begin_tests(configuration).

test(other_player) :-
  other_player(o,x),
  other_player(x,o).

test(cleanup) :-
  game_configuration:assert(move_source(1,2)),
  game_configuration:cleanup,
  \+move_source(_,_).

test(configuration,
     [cleanup(retractall(move_source(_,_)))]) :-
  configure(true),
  move_source(x,human),
  move_source(o,cpu).

test(configuration,
     [cleanup(retractall(move_source(_,_)))]) :-
  configure(false),
  move_source(o,human),
  move_source(x,cpu).

:- end_tests(configuration).
