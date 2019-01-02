-module(beer_song).
-export([verse/1,
	 sing/1,
	 sing/2,
	 test_version/0]).

sing(Start) ->
    lists:reverse([ verse(N) ++ "\n" || N <- lists:seq(0, Start) ]).

sing(Start, End) ->
    lists:reverse([ verse(N) ++ "\n" || N <- lists:seq(End, Start) ]).

verse(0) ->
    "No more bottles of beer on the wall, no more bottles of beer.\n" ++
    "Go to the store and buy some more, 99 bottles of beer on the wall.\n";
verse(Number) ->
    first_line_lyric(Number) ++ second_line_lyric(Number-1).

first_line_lyric(N) ->
    io_lib:format("~p bottle~s of beer on the wall, "
		  "~p bottle~s of beer.\n",
		  [N, plural_article(N), N, plural_article(N)]).

second_line_lyric(0) ->
    "Take it down and pass it around, "
    "no more bottles of beer on the wall.\n";
second_line_lyric(N) ->
    io_lib:format("Take one down and pass it around, "
		  "~p bottle~s of beer on the wall.\n",
		  [N, plural_article(N)]).

plural_article(1) ->
    "";
plural_article(_) ->
    "s".

test_version() ->
    1.