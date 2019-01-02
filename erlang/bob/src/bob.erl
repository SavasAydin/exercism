-module(bob).
-export([response/1]).

response(Question) ->
    seq([{fun saying_nothing/1, "Fine. Be that way!"},
         {fun is_yelling_question/1, "Calm down, I know what I'm doing!"},
         {fun is_yelling/1, "Whoa, chill out!"},
         {fun is_question/1, "Sure."}],
        Question).

seq([], _) ->
    get_default_response();
seq([{Fun, Response} | Funs], Question) ->
    case Fun(Question) of
        true ->
            Response;
        false ->
            seq(Funs, Question)
    end.

get_default_response() ->
    "Whatever.".

saying_nothing(Text) ->
    contains_only_space_characters(Text).

contains_only_space_characters(Text) ->
    lists:all(fun(X) -> lists:member(X, spaces()) end, Text).

spaces() ->
    [$\t, $\n, $\v, $\r, $\s ,$\xA0, $\x{2002}].

is_yelling_question(Text) ->
    is_yelling(Text) andalso is_question(Text).

is_yelling(Text) ->
    contains_letter(Text) andalso string:to_upper(Text) == Text.

contains_letter(Text) ->
    re:run(Text, "[a-zA-Z]") /= nomatch.

is_question(Text) ->
    lists:last(string:strip(Text, right)) == $?.
