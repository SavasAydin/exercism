-module(anagram).
-export([find_anagrams/2]).

find_anagrams(Word, Anagrams) ->
    [ X || X <- Anagrams,
           letters_in_different_order(X, Word),
           contains_same_letters(X, Word) ].

letters_in_different_order(Word1, Word2) ->
    lowercase(Word1) /= lowercase(Word2).

contains_same_letters(Word1, Word2) ->
    sort_letters(Word1) == sort_letters(Word2).

sort_letters(Word) ->
    lists:sort(lowercase(Word)).

lowercase(Word) ->
    string:to_lower(Word).
