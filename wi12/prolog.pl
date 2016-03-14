% 4a
sorted([]).
sorted([_]).
sorted([A,B|T]) :- A =< B, sorted([B|T]).

% 4b
% sort_(L1,L2) :- permutation(L1,L2), sorted(L2).

% 4b bonus
sort_(L1,L2) :- permutation(L1,L2), sorted(L2), !.

% 4c
split([],[],[]).
split([X],[X],[]).
split([X|T], [X|Xs], [Y|Ys]) :- split(T, [Y|Ys], Xs).

% 4d
merge([],L,L).
merge(L,[],L).
merge([H1|T1], [H2|T2], [H1|T]) :- H1 =< H2, merge(T1,[H2|T2],T).
merge([H1|T1], [H2|T2], [H2|T]) :- H1 > H2, merge([H1|T1],T2,T).

% 4e
merge_sort([],[]).
merge_sort([X],[X]).
merge_sort(L,S) :- split(L, ODD, EVEN),
                   merge_sort(ODD,ODD_SORTED),
                   merge_sort(EVEN, EVEN_SORTED),
                   merge(ODD_SORTED, EVEN_SORTED, S).
