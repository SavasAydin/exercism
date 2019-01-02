-module(hamming).
-export([hamming_distance/2,
	 test_version/0]).

hamming_distance(Strand1, Strand2) ->
    hamming_distance(Strand1, Strand2, 0).

hamming_distance([], [], Count) ->
    Count;
hamming_distance([H|T1], [H|T2], Count) ->
    hamming_distance(T1, T2, Count);
hamming_distance([_|T1], [_|T2], Count) ->
    hamming_distance(T1, T2, Count+1).

test_version() ->
    1.