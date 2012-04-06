:-  module(board_utils,[ai_winner/1,col/2,row/2,winner/1,winner/2]).

col(point(_,Col_1),point(_,Col_1)).
row(point(Row_1,_),point(Row_1,_)).

winner(P) :-
  findall(_,ttt:move(_,_),Moves),
  write(Moves),
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

diagonal_winner(Move_predicate, P) :-
  call(Move_predicate,point(0,2),P),
  call(Move_predicate,point(1,1),P),
  call(Move_predicate,point(2,0),P).
