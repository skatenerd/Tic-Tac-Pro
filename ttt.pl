:-  module(ttt,[in_valid_range/2,ai_winner/1,get_input/1,valid_inputs/1,valid_input/1,print_board/0,col/2,row/2,winner/1,move/2,num_unique/2,any/2,check_length/2,dumb_cpu_move/2]).
:- use_module(library(lists)).
:- dynamic move/2.
col(point(_,Col_1),point(_,Col_1)).
row(point(Row_1,_),point(Row_1,_)).

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

get_input(Input) :-
  repeat,
  write('Please enter input 0-8 corresponding to unoccupied square'),nl,
  read(Current_input),
  valid_input(Current_input),
  input_to_row_col(Current_input,Row,Col),
  Input=[Row,Col].

write_square([]) :-
  write('_').

write_square([Occupant]) :-
  write(Occupant).

print_row(R) :-
  findall(P,move(point(R,0),P),Occupants0),
  write_square(Occupants0),
  write('|'),
  findall(P,move(point(R,1),P),Occupants1),
  write_square(Occupants1),
  write('|'),
  findall(P,move(point(R,2),P),Occupants3),
  write_square(Occupants3),
  nl.

print_board :-
  print_row(0),
  print_row(1),
  print_row(2).

check_length(Len,List) :-
  length(List,Len).

winner(P) :-
  findall(_,move(_,_),Moves),
  length(Moves,N),
  N>4,
  winner(ttt:move,P).

ai_winner(P) :-
  findall(_,ai:real_or_imagined_move(_,_),Moves),
  length(Moves,N),
  N>4,
  winner(ai:real_or_imagined_move,P).

winner(Move_predicate, P) :-
  moves_constitute_win(Move_predicate, P).

moves_constitute_win(Move_predicate, P) :-
  col_winner(Move_predicate, P).

moves_constitute_win(Move_predicate, P) :-
  row_winner(Move_predicate, P).

moves_constitute_win(Move_predicate, P) :-
  diagonal_winner(Move_predicate, P).


col_winner(Move_predicate, P) :-
  /*findall(M,bagof(R,move(point(R,_),P),M),Z),
  any(check_length(3),Z).*/
  call(Move_predicate,point(0,C),P),
  call(Move_predicate,point(1,C),P),
  call(Move_predicate,point(2,C),P).
  
row_winner(Move_predicate, P) :-
  /*findall(M,bagof(C,move(point(_,C),P),M),Z),
  any(check_length(3),Z).*/
  call(Move_predicate,point(R,0),P),
  call(Move_predicate,point(R,1),P),
  call(Move_predicate,point(R,2),P).
  

diagonal_winner(Move_predicate, P) :-
  call(Move_predicate,point(0,0),P),
  call(Move_predicate,point(1,1),P),
  call(Move_predicate,point(2,2),P).

diagonal_winner(P) :-
  move(point(0,2),P),
  move(point(1,1),P),
  move(point(2,0),P).

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
