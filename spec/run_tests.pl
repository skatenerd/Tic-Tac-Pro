:- module(run_tests).

run_all :-
  consult('spec/board_utils_spec.pl'),
  run_tests(utils),
  consult('spec/ai_spec.pl'),
  run_tests(ai),
  consult('spec/game_configuration_spec.pl'),
  run_tests(configuration),
  consult('spec/players_spec.pl'),
  run_tests(players),
  consult('spec/ttt_spec.pl'),
  run_tests(ttt),
  consult('spec/io_spec.pl'),
  run_tests(io),
  consult('spec/mocks/ai_spec.pl'),
  run_tests(mock_ai),
  consult('spec/mocks/board_utils_spec.pl'),
  run_tests(mock_board_utils),
  consult('spec/mocks/io_spec.pl'),
  run_tests(mock_io),
  consult('spec/mocks/players_spec.pl'),
  run_tests(mock_players).
