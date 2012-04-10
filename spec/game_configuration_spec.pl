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

:- end_tests(configuration).
