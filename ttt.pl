:-  module(ttt,[initialize_game/0,valid_input/1,move/2,num_unique/2,any/2,check_length/2]).
:- use_module(library(lists)).
:- use_module(board_utils).
:- use_module(io).
:- dynamic move/2.
:- dynamic move_source/2.

valid_input(Input) :-
  integer(Input),
  io:input_to_row_col(Input,Row,Col),
  board_utils:legal(move,[Row,Col]).

check_length(Len,List) :-
  length(List,Len).

num_unique(L,N) :-
  list_to_set(L,S),
  length(S,N).

initialize_game :-
  see(user_input),
  write('welcome'),
  assert(move_source(x,human)),
  assert(move_source(o,cpu)),
  game_loop(x).

game_over :-
  board_full(move).

game_over :-
  findall(W,winner(W),Winners),
  \+Winners=[].
  

game_loop(_) :-
  game_over,
  write('Game over, final board was'),
  nl,
  print_board,
  ai:retractall(imagined_move(_,_)),
  ttt:retractall(move(_,_)).

game_loop(Player) :-
  other_player(Player,Other),
  move_source(Player,Source),
  turn(Source),
  game_loop(Other).

turn(human) :-
  write('the board is: '),
  nl,
  print_board, 
  io:get_input([Row,Col]),
  nl,
  assert(move(point(Row,Col),x)).

turn(cpu) :-
  ai:smart_cpu_move(o,Cpu_move),
  assert(Cpu_move).
  
  

any(_,[]) :-
  false.

any(P,[H|_]) :-
  call(P,H).

any(P,[_|T]) :-
  any(P,T).
