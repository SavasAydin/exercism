-module(grains).
-export([square/1,
         total/0]).

square(N) when N < 1 orelse N > 64 ->
    {error, "square must be between 1 and 64"};
square(Number) ->
    round(math:pow(2, Number-1)).

total() ->
    Res = [ square(N) || N <- lists:seq(1,64) ],
    lists:sum(Res).
