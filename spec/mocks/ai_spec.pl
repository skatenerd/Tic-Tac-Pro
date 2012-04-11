:- module(mock_ai_spec,[]).
:- begin_tests(mock_ai).

test(setup) :-
  load_files('spec/mocks/ai.pl',[redefine_module(true)]).

test(unbeatable_cpu_move) :-
  unbeatable_cpu_move(x,Output),
  Output=move(point(1,1),x),
  ai:calls(unbeatable_cpu_move,x),
  
  ai:retractall(calls(_,_)).

test(cleanup) :-
  load_files('src/ai.pl',[redefine_module(true)]).
  


:- end_tests(mock_ai).
