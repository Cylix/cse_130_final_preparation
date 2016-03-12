% 2a
remove_all(_, [], []).
remove_all(X, [X|T], FILTERED_TAIL) :- remove_all(X, T, FILTERED_TAIL).
remove_all(X, [H|T], [H|FILTERED_TAIL]) :- not(X = H), remove_all(X, T, FILTERED_TAIL).

% 2b
remove_first(_, [], []).
remove_first(X, [X|T], T).
remove_first(X, [H|T], [H|FILTERED_TAIL]) :- not(X = H), remove_first(X, T, FILTERED_TAIL).

% 2c
prefix([], _).
prefix([H1|T1], [H1|T2]) :- prefix(T1, T2).

% 2d
segment(L1,L2) :- prefix(L1, L2).
segment(L1, [_|T2]) :- segment(L1, T2).
