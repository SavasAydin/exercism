-module(meetup).
-export([schedule/4,
	 test_version/0]).

schedule(Year, Month, DayName, Which) ->
    DayNums = days_of_the_month(Year, Month, DayName),
    Day = which_day_num(DayNums, Which),
    {Year, Month, Day}.

days_of_the_month(Year, Month, DayName) ->
    NumberOfDays = calendar:last_day_of_the_month(Year, Month),
    DayNum = proplists:get_value(DayName, days_of_week()),
    Fun = fun(X) -> calendar:day_of_the_week(Year, Month, X) end,
    [ X || X <- lists:seq(1, NumberOfDays), Fun(X) == DayNum ].

which_day_num(DayNums, last) ->
    lists:last(DayNums);
which_day_num(DayNums, teenth) ->
    [DayNum] = [ N || N <- DayNums, N >= 13 andalso N =< 19 ],
    DayNum;
which_day_num(DayNums, Which) ->
    lists:nth(proplists:get_value(Which, weeks_of_month()), DayNums).

days_of_week() ->
    [{monday, 1},
     {tuesday, 2},
     {wednesday, 3},
     {thursday, 4},
     {friday, 5},
     {saturday, 6},
     {sunday, 7}].

weeks_of_month() ->
    [{first, 1},
     {second, 2},
     {third, 3},
     {fourth, 4}].

test_version() ->
    1.