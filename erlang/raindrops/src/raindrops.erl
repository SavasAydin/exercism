-module(raindrops).

-export([convert/1]).

-define(FACTORS, [{3, "Pling"}, {5, "Plang"}, {7, "Plong"}]).

convert(Number) ->
    convert(Number, ?FACTORS, "").

convert(Number, [{F, O}|Factors], Acc) when Number rem F == 0 ->
    convert(Number, Factors, Acc ++ O);
convert(Number, [_|Factors], Acc) ->
    convert(Number, Factors, Acc);
convert(Number, [], "") ->
    integer_to_list(Number);
convert(_, [], Output) ->
    Output.
