:-  module(ttt,[in_valid_range/2,ai_winner/1,valid_inputs/1,valid_input/1,col/2,row/2,winner/1,move/2,num_unique/2,any/2,check_length/2,dumb_cpu_move/2]).
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
