:- module(game_configuration_spec, []).
:- use_module(src/game_configuration).
:- begin_tests(configuration).

test(other_player) :-
  other_player(o,x),
  other_player(x,o).

:- end_tests(configuration).
