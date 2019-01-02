-module(roman_numerals).
-export([numerals/1,
	 test_version/0]).

numerals(0) ->
    "";
numerals(Number) ->
    [{L, R}] = find_interval_and_representation(Number),
    R ++ numerals(Number-L).

find_interval_and_representation(Number) ->
    [ {Low, Roman} || {Low, High, Roman} <- intervals_and_representations(),
		      Number >= Low andalso Number < High].

intervals_and_representations() ->
    [{1, 4, "I"},
     {4, 5, "IV"},
     {5, 9, "V"},
     {9, 10, "IX"},
     {10, 40, "X"},
     {40, 50, "XL"},
     {50, 90, "L"},
     {90, 100, "XC"},
     {100, 400, "C"},
     {400, 500, "CD"},
     {500, 900, "D"},
     {900, 1000, "CM"},
     {1000, 3001, "M"}].

test_version() ->
    1.