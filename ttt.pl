:-  module(ttt,[in_valid_range/2,valid_inputs/1,valid_input/1,move/2,num_unique/2,any/2,check_length/2,dumb_cpu_move/2]).
:- use_module(library(lists)).
:- dynamic move/2.

unoccupied(Row,Col) :-
  unoccupied(ttt:move,Row,Col).

unoccupied(Move_predicate,Row,Col) :-
  \+call(Move_predicate,point(Row,Col),_).

input_to_row_col(Input,Row,Col) :-
  Row is Input//3,
  Col is Input mod 3.

valid_input(Input) :-
  integer(Input),
  input_to_row_col(Input,Row,Col),
  legal([Row,Col]).

legal([Row,Col]) :-
  in_valid_range(Row,Col),
  unoccupied(Row,Col).

legal(point(Row,Col)) :-
  legal([Row,Col]).

ai_legal(point(Row,Col)) :-
  in_valid_range(Row,Col),
  unoccupied(ai:real_or_imagined_move,Row,Col).

in_valid_range(Row,Col) :-
  between(0,2,Row),
  between(0,2,Col).

valid_inputs(Valid_inputs) :-
  findall(point(Row,Col),in_valid_range(Row,Col),Inputs),
  include(ai_legal,Inputs,Valid_inputs).



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
  get_input([Row,Col]),
  nl,
  assert(move(point(Row,Col),x)),
  dumb_cpu_move(o,Cpu_move),
  assert(Cpu_move),
  findall(W,winner(W),Winners),
  game(Winners).

game :-
  game([]).

dumb_cpu_move(Player,Move) :-
  repeat,
  random(0,3,Row),
  random(0,3,Col),
  unoccupied(Row,Col),
  Move=move(point(Row,Col),Player).


any(_,[]) :-
  false.

any(P,[H|_]) :-
  call(P,H).

any(P,[_|T]) :-
  any(P,T).
