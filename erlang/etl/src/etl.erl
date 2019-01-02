-module(etl).
-export([transform/1,
	 test_version/0]).

transform(Legacy) ->
    [ {string:to_lower(NewKey), Point} || {Point, OldValues} <- Legacy,
					  NewKey <- OldValues ].

test_version() ->
    1.