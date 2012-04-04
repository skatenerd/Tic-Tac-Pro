:-  module(ttt,[print_board/0,corner/2,col/2,row/2,in_bounds/1,winner/1,move/2,num_unique/2,any/2,check_length/2,dumb_cpu_move/2]).
:- use_module(library(lists)).
:- dynamic move/2.
corner(0,0).
corner(2,2).
corner(0,2).
corner(2,0).
col(point(_,Col_1),point(_,Col_1)).
row(point(Row_1,_),point(Row_1,_)).

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

in_bounds(point(X,Y)) :-
  X<3,
  X>0,
  Y<3,
  Y>0.

winner(P) :-
  col_winner(P).

winner(P) :-
  row_winner(P).

winner(P) :-
  diagonal_winner(P).

any(_,[]) :-
  false.

any(P,[H|_]) :-
  call(P,H).

any(P,[_|T]) :-
  any(P,T).

dumb_cpu_move(Player,Move) :-
  repeat,
  random(0,3,Row),
  random(0,3,Col),
  \+move(point(Row,Col),_),
  Move=move(point(Row,Col),Player).

col_winner(P) :-
  findall(M,bagof(R,move(point(R,C),P),M),Z),
  any(check_length(3),Z).
  
row_winner(P) :-
  findall(M,bagof(C,move(point(R,C),P),M),Z),
  any(check_length(3),Z).

diagonal_winner(P) :-
  move(point(0,0),P),
  move(point(1,1),P),
  move(point(2,2),P).

diagonal_winner(P) :-
  move(point(0,2),P),
  move(point(1,1),P),
  move(point(2,0),P).

num_unique(L,N) :-
  list_to_set(L,S),
  length(S,N).

game([H|T]) :-
  write('Game over, final board was'),
  nl,
  print_board.

game :-
  game([]).

game([]) :-
  write('the board is: '),
  nl,
  print_board, 
  write('enter move: '),
  read((Row,Col)),
  nl,
  assert(move(point(Row,Col),x)),
  dumb_cpu_move(o,Cpu_move),
  assert(Cpu_move),
  findall(W,winner(W),Winners),
  game(Winners).
