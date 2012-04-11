:- module(ttt_spec,[]).

cleanup_assertions :-
  retractall(game_configuration:move_source(_,_)),
  retractall(board_utils:game_over_probability(1)),
  retractall(board_utils:calls(_,_)),
  retractall(players:calls(_,_)),
  retractall(io:calls(_,_)).

:- begin_tests(ttt).
:- use_module(src/ttt).
:- use_module(src/board).
:- use_module(spec/assertions).

test(input_validation) :-
  valid_input(0),
  valid_input(8),
  board:assert(move(point(0,2),x)),
  \+valid_input(2),
  \+valid_input("hello"),
  \+valid_input(33).

test(load_mocks) :-
  load_files('spec/mocks/io.pl',[redefine_module(true)]),
  load_files('spec/mocks/board_utils.pl',[redefine_module(true)]),
  load_files('spec/mocks/players.pl',[redefine_module(true)]).

/*This test will randomly fail one in a thousand runs.
Not sure if the tradeoff of a more complicated test is worth it*/
test(game_loop,
     [cleanup(cleanup_assertions)]) :-
  configure(true),
  board_utils:assert(game_over_probability(0.001)),

  with_output_to(codes(_), ttt:game_loop(x)),
  assertion(board_utils:calls(game_over,board:move)),
  assertion(players:calls(turn,[human,x])).
  
test(game_loop,
     [cleanup(cleanup_assertions)]) :-
  configure(true),
  board_utils:assert(game_over_probability(1)),
  with_output_to(codes(_), ttt:game_loop(x)),

  assertion(\+players:calls(turn,[human,x])),
  assertion(io:calls(farewell,_)).

test(initialization,
     [cleanup(game_configuration:retractall(move_source(_,_)))]) :-
  board_utils:assert(game_over_probability(1)),
  initialize_game,
  assertion(io:calls(prompt_if_human_first,_)).


test(unload_mocks) :-
  load_files('src/io.pl',[redefine_module(true)]),
  load_files('src/board_utils.pl',[redefine_module(true)]),
  load_files('src/players.pl',[redefine_module(true)]).

:-end_tests(ttt).
