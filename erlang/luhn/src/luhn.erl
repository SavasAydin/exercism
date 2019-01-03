-module(luhn).
-export([valid/1]).

valid(Str) ->
    S = remove_spaces(Str),
    valid_length(S) andalso all_digits(S) andalso check_sum(S) rem 10 == 0.

remove_spaces(Str) ->
    [X || X <- Str, X /= $\s].

valid_length(Str) ->
    length(Str) > 1.

all_digits(Str) ->
    lists:all(fun(X) -> X >= $0 andalso X =< $9 end, Str).

check_sum(Str) ->
    Numbers = double_every_second(Str),
    lists:sum(Numbers).

double_every_second(Str) ->
    Indices = lists:zip(lists:seq(1, length(Str)), lists:reverse(Str)),
    [double_even_indices(X) || X <- Indices].

double_even_indices({I, N}) when I rem 2 == 0 ->
    double(list_to_integer([N]));
double_even_indices({_, N}) ->
    list_to_integer([N]).

double(N) when N > 4 ->
    N * 2 - 9;
double(N) ->
    2 * N.
