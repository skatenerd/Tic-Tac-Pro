:- module(mock_board_utils_spec,[]).
:- begin_tests(mock_board_utils).

test(setup) :-
  load_files('spec/mocks/board_utils.pl',[redefine_module(true)]).

test(game_over) :-
  board_utils:assert(game_over_probability(1)),
  game_over(predicate),
  board_utils:calls(game_over,predicate),
  
  board_utils:retractall(calls(_,_)),
  board_utils:retractall(game_over_probability(_)).

test(game_over) :-
  board_utils:assert(game_over_probability(0)),
  \+game_over(predicate),
  board_utils:calls(game_over,predicate),
  
  board_utils:retractall(calls(_,_)),
  board_utils:retractall(game_over_probability(_)).

test(cleanup) :-
  load_files('src/board_utils.pl',[redefine_module(true)]).
  

:- end_tests(mock_board_utils).
