-module(grade_school).
-export([new/0,
	 add/3,
	 get/2,
	 sort/1,
	 test_version/0]).

new() ->
    [].

add(Name, Grade, Roster) ->
    Names = get(Grade, Roster),
    NewRoster = proplists:delete(Grade, Roster),
    [{Grade, [Name|Names]} | NewRoster].

get(Grade, Roster) ->
    proplists:get_value(Grade, Roster, []).

sort(Roster) ->
    lists:sort([{G, lists:sort(N)} || {G, N} <- Roster]).

test_version() ->
    1.