-module(accumulate).
-export([accumulate/2,
	 test_version/0]).

accumulate(F, L) ->
    [ F(X) || X <- L ].

test_version() ->
    1.