:- module(board_utils_spec, []).
:- use_module(src/board).
:- use_module(src/board_utils).
:- use_module(src/ai).
:- use_module(assertions).

:- begin_tests(utils).

test(board_full) :-
  assertions:assert_row(0, x),
  \+board_full(board:move),
  assertions:assert_row(1, x),
  assertions:assert_row(2, x),
  board_full(board:move),
  assertions:clear_moves.

test(diagonal_win_detection) :-
  assertions:assert_diagonal(x),
  board:assert(move(point(0, 0), o)),
  board:assert(move(point(0, 1), o)),
  findall(W, winner(board:move, W), Winners),
  member(x, Winners),
  assertions:clear_moves.

test(row_win_detection) :-
  assertions:assert_row(2, x),
  board:assert(move(point(1, 0), o)),
  board:assert(move(point(1, 1), o)),
  findall(W, winner(board:move, W), Winners),
  member(x, Winners),
  assertions:clear_moves.

test(col_win_detection) :-
  assertions:assert_col(0, x),
  board:assert(move(point(1, 0), o)),
  board:assert(move(point(1, 1), o)),
  findall(W, winner(board:move, W), Winners),
  member(x, Winners),
  assertions:clear_moves.

test(detects_wins_asserted_by_ai,
     [cleanup(ai:retractall(imagined_move(_, _)))]) :-
  board:assert(move(point(0, 0), o)),
  board:assert(move(point(0, 1), o)),
  ai:assert(imagined_move(point(0, 2), o)),
  board:assert(move(point(1, 0), x)),
  board:assert(move(point(2, 0), x)),
  findall(W, winner(ai:real_or_imagined_move, W), Winners),
  member(o, Winners),
  assertions:clear_moves.

test(all_winners) :-
  assertions:assert_row(0, o),
  board:assert(move(point(1, 1), x)),
  board:assert(move(point(2, 2), x)),
  findall(Winner, winner(board:move, Winner), Winners),
  assertion(Winners = [o]),
  assertion(\+Winners = [x]),
  assertions:clear_moves.

test(move_legality) :-
  assertions:assert_row(0, o),
  assertions:assert_row(1, o),
  legal(board:move, [2, 2]),
  assertions:clear_moves.

:-end_tests(utils).
