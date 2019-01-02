-module(leap).
-export([leap_year/1,
	 test_version/0]).

leap_year(Year) ->
    divisible_by(Year, 4) andalso
    (not divisible_by(Year, 100) orelse divisible_by(Year, 400)).

divisible_by(Year, Number) ->
    Year rem Number == 0.

test_version() ->
    1.