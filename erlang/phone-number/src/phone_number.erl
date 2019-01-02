-module(phone_number).
-export([number/1,
	 areacode/1,
	 pretty_print/1,
	 test_version/0]).

number(PhoneNumber) ->
    Tel = remove_punctuation(PhoneNumber),
    cleanup_number(Tel).

remove_punctuation(PhoneNumber) ->
    [ X || X <- PhoneNumber, is_numeric(X) ].

is_numeric(Char) ->
    Char >= $0 andalso Char =< $9.

cleanup_number([$1 | Number])when length(Number) == 10 ->
    Number;
cleanup_number(Number) when length(Number) == 10 ->
    Number;
cleanup_number(_) ->
    string:copies("0", 10).

areacode(Tel) ->
    {AreaCode, _} = lists:split(3, Tel),
    AreaCode.

pretty_print([$1 | Tel]) when length(Tel) == 10 ->
    pretty_print(Tel);
pretty_print(Tel) ->
    {AreaCode, ExchangeCode, SubscriberNumber} = split_nanp_numbers(Tel),
    "(" ++ AreaCode ++ ") " ++ ExchangeCode ++ "-" ++ SubscriberNumber.

split_nanp_numbers(Tel) ->
    {AreaCode, LocalNumber} = lists:split(3, Tel),
    {ExchangeCode, SubscriberNumber} = lists:split(3, LocalNumber),
    {AreaCode, ExchangeCode, SubscriberNumber}.

test_version() ->
    1.