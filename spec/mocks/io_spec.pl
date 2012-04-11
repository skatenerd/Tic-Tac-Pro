:- module(mock_io_spec,[]).
:- begin_tests(mock_io).

test(setup) :-
  load_files('spec/mocks/io.pl',[redefine_module(true)]).

test(get_move_input) :-
  get_move_input(x,Input),
  Input=[1,1],
  io:calls(get_move_input,x),

  io:retractall(calls(_,_)).

test(cleanup) :-
  load_files('src/io.pl',[redefine_module(true)]).

:- end_tests(mock_io).
