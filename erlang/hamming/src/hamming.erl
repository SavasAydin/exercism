-module(hamming).
-export([distance/2]).

distance(S1, S2) when length(S1) /= length(S2) ->
    {error, "left and right strands must be of equal length"};
distance(Strand1, Strand2) ->
    distance(Strand1, Strand2, 0).

distance([], [], Count) ->
    Count;
distance([H|T1], [H|T2], Count) ->
    distance(T1, T2, Count);
distance([_|T1], [_|T2], Count) ->
    distance(T1, T2, Count+1).
