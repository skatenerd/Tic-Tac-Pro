:-  module(a).
:- use_module(b).

dbtest :-
  assert(point(a,a)),
  b:assert(point(b,b)),
  listing,
  write('-------'),
  blisting(33).

big(X) :-
  between(20,40,X),
  X>33.
  
