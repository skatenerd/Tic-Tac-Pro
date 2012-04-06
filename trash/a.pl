:-  module(a).
:- use_module(b).

dbtest :-
  assert(point(a,a)),
  b:assert(point(b,b)),
  listing,
  write('-------'),
  blisting(33).
