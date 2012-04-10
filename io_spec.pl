:- module(io_spec,[]).

:- begin_tests(io).
:- load_files('io.pl',[redefine_module(true)]).
:- load_files('ttt.pl',[redefine_module(true)]).
:- load_files('ttt_spec.pl',[redefine_module(true)]).

/*test(get_input) :-
  see('input.txt'),
  get_input(I),
  I=[1,0],
  see(user_input).*/

test(printing) :-
  ttt_spec:assert_row(0,x),
  with_output_to(codes(Output),print_board),
  format("~s",[Output]),
  assertion(Output="x|x|x\n_|_|_\n_|_|_\n"),
  ttt_spec:clear_moves.

:- unload_file('io.pl').
:- unload_file('ttt.pl').
:- unload_file('ttt_spec.pl').

:- end_tests(io).
