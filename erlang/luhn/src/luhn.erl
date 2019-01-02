-module(luhn).
-export([valid/1,
	 create/1,
	 test_version/0]).

create(String) ->
    N = find_missing_number(String),
    string:concat(String, N).

valid(String) ->
    check_sum(String) rem 10 == 0.

remove_spaces(String) ->
    [ X || X <- String, X /= $\s ].

find_missing_number(S) ->
    N = check_sum(S ++ [$0]),
    integer_to_list(10 - N rem 10).

check_sum(String) ->
    S = remove_spaces(String),
    Numbers = double_every_second(S),
    lists:sum(Numbers).

double_every_second(S) ->
    WithIndices = lists:zip(lists:seq(1, length(S)), lists:reverse(S)),
    [ double_even_indices(X) || X <- WithIndices ].

double_even_indices({I, N}) when I rem 2 == 0 ->
    double(list_to_integer([N]));
double_even_indices({_, N}) ->
    list_to_integer([N]).

double(N) when N > 4 ->
    N * 2 - 9;
double(N) ->
    2 * N.

test_version() ->
    1.