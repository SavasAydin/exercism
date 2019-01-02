-module(sum_of_multiples).
-export([sumOfMultiples/2,
	test_version/0]).

sumOfMultiples(Numbers, Number) ->
    Multiples = [ X || X <- lists:seq(1, Number-1), divisible(X, Numbers) ],
    lists:sum(Multiples).

divisible(N, Numbers) ->
    lists:any(fun(X) -> N rem X == 0 end, Numbers).

test_version() ->
    1.