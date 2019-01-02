-module(series).
-export([from_string/2,
         test_version/0]).

from_string(Digit, Number) ->
    StartPositions = lists:seq(1, length(Number)-Digit+1),
    [string:substr(Number, Start, Digit) || Start <- StartPositions].

test_version() ->
    1.