:- module(io_spec,[]).
:- use_module(ttt_spec).
:- use_module(io).
:- begin_tests(io).

/*test(get_input) :-
  see('input.txt'),
  get_input(I),
  I=[1,0],
  see(user_input).*/

test(printing) :-
  ttt_spec:assert_row(0,x),
  with_output_to(codes(Output),io:print_board),
  format("~s",[Output]),
  assertion(Output="x|x|x\n_|_|_\n_|_|_\n"),
  ttt_spec:clear_moves.


:- end_tests(io).
