:- module(io_spec,[]).
:- use_module(ttt_spec).
:- use_module(io).
:- begin_tests(io).

test(input_to_row_col) :-
  input_to_row_col(3,1,0),
  input_to_row_col(4,1,1),
  input_to_row_col(8,2,2).

/*
These are commented out becauase they permanently mutate the state of the file input stream.
I have no idea how to fix that!
Uncommenting these tests means you have to restart the environment every time.

test(get_input,
     [cleanup(see(user_input))]) :-
  see('move_input.txt'),
  with_output_to(codes(_), get_move_input(x,Input)),
  Input=[1,0].

test(prompt_if_human_first,
     [cleanup(see(user_input))]) :-
  see('move_first_input.txt'),
  with_output_to(codes(_), human_first(Human_first)),
  Human_first.*/

test(printing) :-
  ttt_spec:assert_row(0,x),
  with_output_to(codes(Output),io:print_board),
  format("~s",[Output]),
  assertion(Output="x|x|x\n_|_|_\n_|_|_\n"),
  ttt_spec:clear_moves.

:- end_tests(io).
