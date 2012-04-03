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
  move(point(R,0),P),
  move(point(R,1),P),
  move(point(R,2),P).

winner(P) :-
  move(point(0,C),P),
  move(point(1,C),P),
  move(point(2,C),P).

winner(P) :-
  move(point(0,0),P),
  move(point(1,1),P),
  move(point(2,2),P).

winner(P) :-
  move(point(0,2),P),
  move(point(1,1),P),
  move(point(2,0),P).

num_unique(L,N) :-
  list_to_set(L,S),
  length(S,N).

l(_) :-
  listing.
