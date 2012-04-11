:-  module(ttt, [configure/1, initialize_game/0]).
:- load_files('io.pl',[redefine_module(true)]).
:- use_module(library(lists)).
:- use_module(board_utils).
:- use_module(players).
:- use_module(game_configuration).
:- use_module(io).

initialize_game :-
  io:prompt_if_human_first(Human_first),
  game_configuration:configure(Human_first),
  game_loop(x).

game_loop(_) :-
  game_over(board:move),
  io:farewell,
  cleanup.

game_loop(Player_alias) :-
  other_player(Player_alias, Other),
  game_configuration:move_source(Player_alias, Source),
  players:turn(Source, Player_alias),
  game_loop(Other).

cleanup :-
  game_configuration:cleanup,
  ai:retractall(imagined_move(_, _)),
  board:retractall(move(_, _)).
