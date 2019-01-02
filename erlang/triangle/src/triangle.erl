-module(triangle).
-export([kind/3,
	 test_version/0]).

-define(SIDE_LENGTH_ERROR, {error, "all side lengths must be positive"}).
-define(INEQUALITY_ERROR, {error, "side lengths violate triangle inequality"}).

kind(A, B, C) ->
    run_checks([{fun is_any_side_negative_or_zero/1, ?SIDE_LENGTH_ERROR},
		{fun triangle_inequality/1, ?INEQUALITY_ERROR},
		{fun is_equilateral/1, equilateral},
		{fun is_scalene/1, scalene},
		{fun must_be_isosceles/1, isosceles}],
		[A,B,C]).

run_checks([{Fun, Response} | Funs], Sides) ->
    case Fun(Sides) of
	true ->
	    Response;
	false ->
	    run_checks(Funs, Sides)
    end.

is_any_side_negative_or_zero(Sides) ->
    lists:any(fun(X) -> X =< 0 end, Sides).

triangle_inequality(Sides) ->
    Inequality = 2 * lists:max(Sides) < lists:sum(Sides),
    not Inequality.

is_equilateral([A, B, C]) ->
    A == B andalso A == C.

is_scalene([A, B, C]) ->
    A /= B andalso A /= C andalso B /= C.

must_be_isosceles(_) ->
    true.

test_version() ->
    1.