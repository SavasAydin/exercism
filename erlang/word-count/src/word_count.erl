-module(word_count).
-export([count/1,
	 test_version/0]).

count(Text) ->
    Lower = to_lower(Text),
    Clean = remove_special_characters(Lower),
    Words = tokenize(Clean),
    count_occurrences(Words).

to_lower(Text) ->
    string:to_lower(Text).

remove_special_characters(Text) ->
    Options = [global, {return, list}],
    re:replace(Text, "[^0-9a-z]", " ", Options).

tokenize(Text) ->
    string:tokens(Text, " ").

count_occurrences(Words) ->
    [ {Word, count(Word, Words)} || Word <- Words ].

count(Word, Words) ->
    Occurences = [ X || X <- Words, X == Word ],
    length(Occurences).

test_version() ->
    1.