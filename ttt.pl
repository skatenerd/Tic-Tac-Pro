:-  module(ttt,[corner/2,col/2,row/2,in_bounds/1,winner/1,move/2,num_unique/2,any/2,check_length/2,l/1,dumb_cpu_move/2,assert_moves/1,clear_moves/0]).
:- use_module(library(lists)).
:- dynamic move/2.
corner(0,0).
corner(2,2).
corner(0,2).
corner(2,0).
col(point(_,Col_1),point(_,Col_1)).
row(point(Row_1,_),point(Row_1,_)).

assert_moves([]) :-
  true.
assert_moves([H|T]) :-
  assert(H),
  assert_moves(T).
clear_moves :-
  retractall(move(_,_)).

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
  \+move(point(Row,Col),Player),
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

l(_) :-
  listing.
