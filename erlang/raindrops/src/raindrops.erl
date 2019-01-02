-module(raindrops).

-export([convert/1]).

-define(FACTORS, [3, 5, 7]).

convert(Number) ->
    convert(Number, ?FACTORS, "").

convert(Number, [F|Factors], Acc) when Number rem F == 0 ->
    convert(Number, Factors, Acc ++ get_output(F));
convert(Number, [_|Factors], Acc) ->
    convert(Number, Factors, Acc);
convert(Number, [], "") ->
    integer_to_list(Number);
convert(_, [], Output) ->
    Output.

get_output(3) ->
    "Pling";
get_output(5) ->
    "Plang";
get_output(7) ->
    "Plong".
