:- module(ttt_spec,[assert_row/2, assert_col/2, assert_diagonal/1, clear_moves/0]).

assert_row(R,P) :-
  ttt:assert(move(point(R,0),P)),
  ttt:assert(move(point(R,1),P)),
  ttt:assert(move(point(R,2),P)).

assert_col(C,P) :-
  ttt:assert(move(point(0,C),P)),
  ttt:assert(move(point(1,C),P)),
  ttt:assert(move(point(2,C),P)).

assert_diagonal(P) :-
  ttt:assert(move(point(0,0),P)),
  ttt:assert(move(point(1,1),P)),
  ttt:assert(move(point(2,2),P)).

clear_moves :-
  ttt:retractall(move(_,_)).

:- begin_tests(ttt).
:- load_files('ttt.pl',[redefine_module(true)]).

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

test(full_game_does_not_crash,
     [cleanup(see(user_input))]) :-
  see('full_game_input.txt'),
  with_output_to(codes(_), initialize_game).

:- unload_file('ttt.pl').
:-end_tests(ttt).
