:- module(io, [prompt_if_human_first/1, get_move_input/2, farewell/0]).
:- dynamic calls/2.

get_move_input(Alias, Input) :-
  Input=[1,1],
  assert(calls(get_move_input,Alias)).

prompt_if_human_first(_) :-
  assert(calls(prompt_if_human_first,_)).

farewell :-
  assert(calls(farewell,_)).
