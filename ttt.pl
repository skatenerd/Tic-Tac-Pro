:-  module(ttt,[valid_input/1,move/2,num_unique/2,any/2,check_length/2]).
:- use_module(library(lists)).
:- use_module(board_utils).
:- use_module(io).
:- dynamic move/2.

valid_input(Input) :-
  integer(Input),
  io:input_to_row_col(Input,Row,Col),
  board_utils:legal(move,[Row,Col]).

check_length(Len,List) :-
  length(List,Len).

num_unique(L,N) :-
  list_to_set(L,S),
  length(S,N).

game([_|_]) :-
  write('Game over, final board was'),
  nl,
  print_board.

game([]) :-
  see(user_input),
  write('the board is: '),
  nl,
  print_board, 
  io:get_input([Row,Col]),
  nl,
  assert(move(point(Row,Col),x)),
  ai:smart_cpu_move(o,Cpu_move),
  assert(Cpu_move),
  findall(W,winner(W),Winners),
  game(Winners).

game :-
  game([]).

any(_,[]) :-
  false.

any(P,[H|_]) :-
  call(P,H).

any(P,[_|T]) :-
  any(P,T).
