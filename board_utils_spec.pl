:- module(board_utils_spec, []).
:- use_module(ttt).
:- use_module(board_utils).

:- begin_tests(utils).

test(diagonal_detection) :-
  ttt_spec:assert_diagonal(x),
  ttt:assert(move(point(0,0),o)),
  ttt:assert(move(point(0,1),o)),
  findall(W,winner(W),Winners),
  member(x,Winners),
  ttt_spec:clear_moves.

test(board_full) :-
  ttt_spec:assert_row(0,x),
  \+board_full(ttt:move),
  ttt_spec:assert_row(1,x),
  ttt_spec:assert_row(2,x),
  board_full(ttt:move),
  ttt_spec:clear_moves.

test(detects_wins_asserted_by_ai) :-
  ttt:assert(move(point(0,0),o)),
  ttt:assert(move(point(0,1),o)),
  ai:assert(imagined_move(point(0,2),o)),
  ttt:assert(move(point(1,0),x)),
  ttt:assert(move(point(2,0),x)),
  findall(W,ai_winner(W),Winners),
  member(o,Winners),
  ttt_spec:clear_moves,
  ai:retractall(imagined_move(_,_)).

test(row_detection) :-
  ttt_spec:assert_row(2,x),
  findall(W,winner(ttt:move,W),Winners),
  member(x,Winners),
  ttt_spec:clear_moves.

test(col_detection) :-
  ttt_spec:assert_col(0),
  findall(W,winner(ttt:move,W),Winners),
  member(x,Winners),
  ttt_spec:clear_moves.


test(all_winners) :-
  ttt_spec:assert_row(0,o),
  ttt:assert(move(point(1,1),x)),
  ttt:assert(move(point(2,2),x)),
  findall(W,winner(W),Winners),
  assertion(Winners=[o]),
  findall(S,winner(S),Other_winners),
  assertion(\+Other_winners=[x]),
  ttt_spec:clear_moves.

test(legality) :-
  assert_row(0,o),
  assert_row(1,o),
  legal(ttt:move,[2,2]),
  ttt_spec:clear_moves.

:-end_tests(utils).
