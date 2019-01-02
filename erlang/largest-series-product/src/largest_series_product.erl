-module(largest_series_product).
-export([lsp/2,
         test_version/0]).

lsp(_, 0) ->
    1;
lsp(Number, Digit) ->
    case valid_number_and_digit(Number, Digit) of
        true ->
            calculate_lsp(Number, Digit);
        false ->
            error
    end.

valid_number_and_digit(Number, Digit) ->
    Number /= [] andalso Digit >= 0 andalso length(Number) >= Digit andalso all_integers(Number).

all_integers(Numbers) ->
    [ X || X <- Numbers, X >= $0 andalso X =< $9] == Numbers.

calculate_lsp(Number, Digit) ->
    Subsets = generate_subsets(Number, Digit, []),
    product(Subsets, 0).

generate_subsets(Number, Digit, Acc) when length(Number) >= Digit ->
    NewAcc = [string:substr(Number, 1, Digit) | Acc],
    generate_subsets(tl(Number), Digit, NewAcc);
generate_subsets(_, _, Acc) ->
    Acc.

product([], Res) ->
    Res;
product([H|T], Acc) ->
    Product = calculate_product(H),
    product(T, lists:max([Product, Acc])).

calculate_product(Numbers) ->
    lists:foldl(fun(X, Acc) -> Acc * list_to_integer([X]) end,
                1,
                Numbers).

test_version() ->
    1.