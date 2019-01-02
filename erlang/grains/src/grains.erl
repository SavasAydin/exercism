-module(grains).
-export([square/1,
	 total/0,
	 test_version/0]).

square(Number) ->
    round(math:pow(2, Number-1)).

total() ->
    Res = [ square(N) || N <- lists:seq(1,64) ],
    lists:sum(Res).

test_version() ->
    1.