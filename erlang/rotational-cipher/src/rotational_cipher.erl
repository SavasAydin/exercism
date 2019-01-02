-module(rotational_cipher).
-export([encrypt/2,
	 decrypt/2,
	 test_version/0]).

encrypt(Text, RotKey) ->
    [ translate(X, RotKey) || X <- Text ].

decrypt(Cipher, RotKey) ->
    encrypt(Cipher, 26-RotKey).

translate(Char, RotKey) when Char >= $A andalso Char =< $Z ->
    (Char - $A + RotKey) rem 26 + $A;
translate(Char, RotKey) when Char >= $a andalso Char =< $z ->
    (Char - $a + RotKey) rem 26 + $a;
translate(X, _) ->
    X.

test_version() ->
    1.