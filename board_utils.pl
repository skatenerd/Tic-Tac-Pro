:-  module(board_utils,[board_full/1,legal/2,winner/2]).

winner(Move_predicate,P) :-
  findall(_,call(Move_predicate,_,_),Moves),
  length(Moves,N),
  N>4,
  moves_constitute_win(Move_predicate,P).

moves_constitute_win(Move_predicate, P) :-
  col_winner(Move_predicate, P).

moves_constitute_win(Move_predicate, P) :-
  row_winner(Move_predicate, P).

moves_constitute_win(Move_predicate, P) :-
  diagonal_winner(Move_predicate, P).

board_full(Move_predicate) :-
  findall(_,call(Move_predicate,_,_),Moves),
  length(Moves,N),
  N>=9.

col_winner(Move_predicate, P) :-
  call(Move_predicate,point(0,C),P),
  call(Move_predicate,point(1,C),P),
  call(Move_predicate,point(2,C),P).
  
row_winner(Move_predicate, P) :-
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


unoccupied(Move_predicate,Row,Col) :-
  \+call(Move_predicate,point(Row,Col),_).

legal(Move_predicate, [Row,Col]) :-
  in_valid_range(Row,Col),
  unoccupied(Move_predicate,Row,Col).

in_valid_range(Row,Col) :-
  between(0,2,Row),
  between(0,2,Col).
