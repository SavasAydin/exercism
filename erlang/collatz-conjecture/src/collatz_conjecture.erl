-module(collatz_conjecture).
-export([steps/1]).

steps(Number) when Number =< 0 ->
    {error, "Only positive numbers are allowed"};
steps(Number) ->
    count_steps(Number, 0).

count_steps(1, Res) ->
    Res;
count_steps(N, Count) when N rem 2 == 0 ->
    count_steps((N div 2), Count+1);
count_steps(N, Count) ->
    count_steps((3*N+1), Count+1).
