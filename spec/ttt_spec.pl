:- module(ttt_spec,[]).

:- begin_tests(ttt).
:- use_module(src/ttt).
:- use_module(spec/assertions).

test(input_validation) :-
  valid_input(0),
  valid_input(8),
  ttt:assert(move(point(0,2),x)),
  \+valid_input(2),
  \+valid_input("hello"),
  \+valid_input(33).

test(configuration,
     [cleanup(game_configuration:retractall(move_source(_,_)))]) :-
  configure(true),
  game_configuration:move_source(x,human),
  game_configuration:move_source(o,cpu).

test(configuration,
     [cleanup(game_configuration:retractall(move_source(_,_)))]) :-
  configure(false),
  game_configuration:move_source(o,human),
  game_configuration:move_source(x,cpu),
  game_configuration:retractall(move_source(_,_)).
/*
I have commented this test out because it exhausts the filestream, and you cannot run it multiple times.
Uncomment freely

test(full_game_does_not_crash,
     [cleanup(see(user_input))]) :-
  see('spec/full_game_input.txt'),
  with_output_to(codes(_), initialize_game).*/

:-end_tests(ttt).
