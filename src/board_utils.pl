:-  module(board_utils, [game_over/1, board_full/1, legal/2, winner/2]).

game_over(Move_predicate) :-
  board_full(Move_predicate).

game_over(Move_predicate) :-
  findall(Winner, winner(Move_predicate, Winner), Winners),
  \+Winners = [].

winner(Move_predicate, Winner) :-
  col_winner(Move_predicate, Winner).

winner(Move_predicate, Winner) :-
  row_winner(Move_predicate, Winner).

winner(Move_predicate, Winner) :-
  diagonal_winner(Move_predicate, Winner).

board_full(Move_predicate) :-
  findall(_, call(Move_predicate, _, _), Moves),
  length(Moves, N),
  N >= 9.

col_winner(Move_predicate, Winner) :-
  call(Move_predicate, point(0, C), Winner),
  call(Move_predicate, point(1, C), Winner),
  call(Move_predicate, point(2, C), Winner).
  
row_winner(Move_predicate, Winner) :-
  call(Move_predicate, point(R, 0), Winner),
  call(Move_predicate, point(R, 1), Winner),
  call(Move_predicate, point(R, 2), Winner).

diagonal_winner(Move_predicate, Winner) :-
  call(Move_predicate, point(0, 0), Winner),
  call(Move_predicate, point(1, 1), Winner),
  call(Move_predicate, point(2, 2), Winner).

diagonal_winner(Move_predicate, Winner) :-
  call(Move_predicate, point(0, 2), Winner),
  call(Move_predicate, point(1, 1), Winner),
  call(Move_predicate, point(2, 0), Winner).


unoccupied(Move_predicate, Row, Col) :-
  \+call(Move_predicate, point(Row, Col), _).

legal(Move_predicate, [Row, Col]) :-
  in_valid_range(Row, Col),
  unoccupied(Move_predicate, Row, Col).

in_valid_range(Row, Col) :-
  between(0, 2, Row),
  between(0, 2, Col).
