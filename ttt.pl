:-  module(ttt, [initialize_game/0, valid_input/1, move/2]).
:- load_files('io.pl',[redefine_module(true)]).
:- use_module(library(lists)).
:- use_module(board_utils).
:- use_module(players).
:- use_module(game_configuration).
:- dynamic move/2.

valid_input(Input) :-
  integer(Input),
  io:input_to_row_col(Input, Row, Col),
  board_utils:legal(ttt:move, [Row, Col]).

initialize_game :-
  see(user_input),
  write('welcome'),
  game_configuration:assert(move_source(x, human)),
  game_configuration:assert(move_source(o, cpu)),
  game_loop(x).

game_loop(_) :-
  game_over(ttt:move),
  write('Game over, final board was'),
  nl,
  print_board,
  ai:retractall(imagined_move(_, _)),
  ttt:retractall(move(_, _)).

game_loop(Player) :-
  other_player(Player, Other),
  game_configuration:move_source(Player, Source),
  turn(Source),
  game_loop(Other).
