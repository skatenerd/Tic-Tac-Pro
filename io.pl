:- module(io, [print_board/0,get_input/1]).

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

