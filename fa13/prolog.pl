link(san_diego, seattle).
link(seattle, dallas).
link(dallas, new_york).
link(new_york, chicago).
link(new_york, seattle).
link(chicago, boston).
link(boston, san_diego).

% 5a
path_2(A,B) :- link(A, X), link(X, B).

% 5b
path_3(A,B) :- link(A, X), link(X, Y), link(Y, B).

% 5c
path_N(A,B,N) :- N = 1, link(A,B).
path_N(A,B,N) :- N > 1, NTAIL is N - 1, link(A,X), path_N(X,B,NTAIL).

% 5d
path(A,B) :- path_helper(A,B, []).
path_helper(A,B,Seen) :- link(A,B), not(member(B,Seen)).
path_helper(A,B,Seen) :- link(A,C), not(member(C,Seen)), path_helper(C,B,[C|Seen]).
