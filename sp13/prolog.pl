% 3
zip([],[],[]).
zip([H1|T1], [H2|T2], [[H1,H2]|T]) :- zip(T1,T2,T).

% 4a
part([], _, [], []).
part([H|T], PIVOT, [H|R1], R2) :- H =< PIVOT, part(T, PIVOT, R1, R2).
part([H|T], PIVOT, R1, [H|R2]) :- H > PIVOT, part(T, PIVOT, R1, R2).

% 4b
qsort([], []).
qsort([H|T], R) :- part(T, H, LESS_LIST, GREATER_LIST),
                   qsort(LESS_LIST, R_LESS_LIST),
                   qsort(GREATER_LIST, R_GREATER_LIST),
                   append(R_LESS_LIST, [H|R_GREATER_LIST], R).
