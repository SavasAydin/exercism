-module(clock).
-export([create/2,
	 minutes_add/2,
	 to_string/1,
	 test_version/0,
	 is_equal/2]).

create(Hours, Minutes) ->
    M = Hours * 60 + Minutes,
    get_clock(M).

get_clock(M) when M < 0 ->
    Minutes = M + 24*60,
    get_clock(Minutes);
get_clock(M) ->
    {(M div 60) rem 24, M rem 60}.

to_string({H, M}) ->
    lists:flatten(io_lib:format("~2..0b:~2..0b", [H,M])).

minutes_add({H, M}, Minutes) ->
    create(H, M + Minutes).

is_equal(Clock1, Clock2) ->
    Clock1 == Clock2.

test_version() ->
    1.