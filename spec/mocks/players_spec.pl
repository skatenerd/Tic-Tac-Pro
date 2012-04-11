:- module(mock_players_spec,[]).
:- begin_tests(mock_players).

test(setup) :-
  load_files('spec/mocks/players.pl',[redefine_module(true)]).

test(turn) :-
  turn(source,alias),
  players:calls(turn,[source,alias]),
  
  players:retractall(calls(_,_)).

test(cleanup) :-
  load_files('src/players.pl',[redefine_module(true)]).

:- end_tests(mock_players).
