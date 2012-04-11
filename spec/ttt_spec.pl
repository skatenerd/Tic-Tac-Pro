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
  assertion(\+board:move(_,_)),
  assertion(\+ai:imagined_move(_,_)),
  assertion(\+game_configuration:move_source(_,_)), 
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

/*
I have commented this test out because it exhausts the filestream, and you cannot run it multiple times.
Uncomment freely

test(integration,
     [cleanup(see(user_input))]) :-
  see('spec/full_game_input.txt'),
  with_output_to(codes(_), initialize_game),
  \+game_configuration:move_source(_,_). */

:-end_tests(ttt).
