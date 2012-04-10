:- module(io, [print_board/0, get_input/1]).
:- use_module(ttt).

input_to_row_col(Input, Row, Col) :-
  Row is Input//3,
  Col is Input mod 3.

get_input(Input) :-
  repeat,
  write('Please enter input 0-8 corresponding to unoccupied square'), nl,
  read(Current_input),
  valid_input(Current_input),
  input_to_row_col(Current_input, Row, Col),
  Input=[Row, Col].

write_square([]) :-
  write('_').

write_square([Occupant|_]) :-
  write(Occupant).

print_row(R) :-
  findall(P, ttt:move(point(R, 0), P), Square_occupant_0),
  write_square(Square_occupant_0),
  write('|'),
  findall(P, ttt:move(point(R, 1), P), Square_occupant_1),
  write_square(Square_occupant_1),
  write('|'),
  findall(P, ttt:move(point(R, 2), P), Square_occupant_2),
  write_square(Square_occupant_2),
  nl.

print_board :-
  print_row(0),
  print_row(1),
  print_row(2).
