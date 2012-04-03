:-  module(ttt,[corner/2,col/2,row/2,in_bounds/1,winner/1,move/2,num_unique/2]).
:- use_module(library(lists)).
:- dynamic move/2.
corner(0,0).
corner(2,2).
corner(0,2).
corner(2,0).
col(point(_,Col_1),point(_,Col_1)).
row(point(Row_1,_),point(Row_1,_)).

in_bounds(point(X,Y)) :-
  X<4,
  X>0,
  Y<4,
  Y>0.

winner(P) :-
  move(point(R,C1),P),
  move(point(R,C2),P),
  move(point(R,C3),P),
  num_unique([C1,C2,C3],3).

winner(P) :-
  move(point(R1,C),P),
  move(point(R2,C),P),
  move(point(R3,C),P),
  num_unique([R1,R2,R3],3).

num_unique(L,N) :-
  list_to_set(L,S),
  length(S,N).

l(_) :-
  listing.
