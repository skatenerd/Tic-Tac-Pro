:- module(io, [input_to_row_col/3, print_board/0, get_move_input/2, human_first/1]).
:- use_module(ttt).

true_or_false(y, true).
true_or_false(yes, true).
true_or_false(n, false).
true_or_false(no, false).

human_first(Human_first) :-
  repeat,
  write('Would you like to go first? (yes or no)  '),nl,
  read(Input),
  string_to_atom(Input,Atomized),
  downcase_atom(Atomized,Lower_case_input),
  true_or_false(Lower_case_input, Human_first).

input_to_row_col(Input, Row, Col) :-
  Row is Input//3,
  Col is Input mod 3.

show_game_status(Alias) :-
  write('The board is: '),nl,
  print_board, 
  write('You are playing as: '),
  write(Alias),nl.

get_move_input(Alias, Input) :-
  show_game_status(Alias),
  prompt_move(Input).

prompt_move(Input) :-
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
