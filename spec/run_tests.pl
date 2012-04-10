:- module(run_tests).

run_all :-
  consult('spec/board_utils_spec.pl'),
  run_tests(utils),
  consult('spec/ai_spec.pl'),
  run_tests(ai),
  consult('spec/game_configuration_spec.pl'),
  run_tests(configuration),
  consult('spec/ttt_spec.pl'),
  run_tests(ttt),
  consult('spec/io_spec.pl'),
  run_tests(io),
  consult('spec/players_spec.pl'),
  run_tests(players).
