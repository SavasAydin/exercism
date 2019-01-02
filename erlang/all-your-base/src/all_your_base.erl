-module(all_your_base).
-export([convert/3,
	 test_version/0]).

convert(Numbers, SrcBase, DstBase) ->
    seq([fun check_that_numbers_are_zero_or_positive/1,
	 fun check_that_bases_are_valid/1,
	 fun check_that_numbers_are_in_base/1,
	 fun check_that_numbers_are_not_zero_or_empty/1,
	 fun horner_evaluation/1,
	 fun convert_to/1,
	 fun reverse/1],
	[Numbers, SrcBase, DstBase]).

check_that_numbers_are_zero_or_positive(Args) ->
    All = lists:all(fun(X) -> X >= 0 end, hd(Args)),
    check(All, Args, negative).

check_that_bases_are_valid([_, SrcBase, _]) when SrcBase =< 1 ->
    {error, invalid_src_base};
check_that_bases_are_valid([_, _, DstBase]) when DstBase =< 1 ->
    {error, invalid_dst_base};
check_that_bases_are_valid(Args)  ->
    Args.

check_that_numbers_are_in_base(Args) ->
    [Numbers, SrcBase, _] = Args,
    All = lists:all(fun(X) -> X < SrcBase end, Numbers),
    check(All, Args, not_in_base).

check_that_numbers_are_not_zero_or_empty(Args) ->
    Valid = [ X || X <- hd(Args), X /= 0 ] /= [],
    check(Valid, Args, nothing_to_convert).

horner_evaluation([Numbers, SrcBase, DstBase]) ->
    Horner = lists:foldl(fun(X, Acc) -> Acc * SrcBase + X end,
			 hd(Numbers),
			 tl(Numbers)),
    [Horner, SrcBase, DstBase].

convert_to([Number, SrcBase, DstBase]) ->
    case Number div DstBase of
	0 ->
	    [Number rem DstBase];
	Div ->
	    [Number rem DstBase | convert_to([Div, SrcBase, DstBase])]
    end.

reverse(Numbers) ->
    lists:reverse(Numbers).

check(Condition, Args, ErrorResponse) ->
    case Condition of
	true ->
	    Args;
	false ->
	    {error, ErrorResponse}
    end.

seq([], Res) ->
    {ok, Res};
seq(_,	{error, nothing_to_convert}) ->
    {ok, []};
seq(_, {error, Response}) ->
    {error, Response};
seq([F | Funs],	Args) ->
    seq(Funs, F(Args)).

test_version() ->
    1.