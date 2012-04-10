:- module(run_tests).

run_all :-
  consult('board_utils_spec.pl'),
  run_tests(utils),
  consult('ai_spec.pl'),
  run_tests(ai),
  consult('game_configuration_spec.pl'),
  run_tests(configuration),
  consult('players_spec.pl'),
  run_tests(players),
  consult('ttt_spec.pl'),
  run_tests(ttt),
  consult('io_spec.pl'),
  run_tests(io).
