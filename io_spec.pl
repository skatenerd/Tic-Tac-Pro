:- module(io_spec,[]).
:- use_module(io). 
:- begin_tests(io).

/*test(get_input) :-
  see('input.txt'),
  get_input(I),
  I=[1,0],
  see(user_input).*/

test(printing) :-
  assert_row(0,x),
  with_output_to(codes(Codes),print_board),
  format("~s",[Codes]),
  assertion(Codes="x|x|x\n_|_|_\n_|_|_\n"),
  clear_moves.
:- end_tests(io).
