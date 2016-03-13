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
% Not sure: in the subject, there is no blank space inside "[X|T]", but I don't see another way to do it
split([X,Y|T], [X|T_EVEN], [Y|T_ODD]) :- split(T,T_EVEN,T_ODD).

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
