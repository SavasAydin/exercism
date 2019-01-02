-module(difference_of_squares).
-export([sum_of_squares/1,
         square_of_sums/1,
         difference_of_squares/1,
         test_version/0]).

sum_of_squares(N) ->
    sum_of_squares(N, 0).

sum_of_squares(0, Res) ->
    Res;
sum_of_squares(N, Acc) ->
    sum_of_squares(N-1, Acc + N * N).

square_of_sums(N) ->
    S = sum_of(N, 0),
    S * S.

sum_of(0, Res) ->
    Res;
sum_of(N, Acc) ->
    sum_of(N-1, Acc+N).

difference_of_squares(N) ->
    square_of_sums(N) - sum_of_squares(N).

test_version() ->
    1.