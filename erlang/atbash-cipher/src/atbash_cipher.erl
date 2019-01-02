-module(atbash_cipher).
-export([encode/1,
	 decode/1,
	 test_version/0]).

encode(Text) ->
    Str = string:to_lower(Text),
    Cipher = convert(Str),
    group(Cipher).

decode(Cipher) ->
    convert(Cipher).

convert(Str) ->
    Atbash = generate_atbash_cipher(),
    [ convert_char(X, Atbash) || X <- Str, not is_excluded(X) ].

generate_atbash_cipher() ->
    Alphabet = lists:seq($a, $z),
    Backwards = lists:reverse(Alphabet),
    lists:zip(Alphabet, Backwards).

convert_char(Char, Atbash) ->
    proplists:get_value(Char, Atbash, Char).

is_excluded(Char) ->
    lists:member(Char, [$., $,, $\s]).

group(Cipher) when length(Cipher) =< 5 ->
    Cipher;
group(Cipher) ->
    {Grouped, Remaining} = lists:split(5, Cipher),
    Grouped ++ " " ++ group(Remaining).

test_version() ->
    1.