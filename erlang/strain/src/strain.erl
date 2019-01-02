-module(strain).
-export([keep/2,
	 discard/2,
	 test_version/0]).

keep(Fun, L) ->
    [ X || X <- L, Fun(X) ].

discard(Fun, L) ->
    [ X || X <- L, not Fun(X) ].

test_version() ->
    1.