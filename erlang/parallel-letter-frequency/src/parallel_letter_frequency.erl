-module(parallel_letter_frequency).
-export([dict/1,
         test_version/0]).

dict(Words) ->
    Word = lists:concat(Words),
    dict:from_list([spawn_count(L, Word) || L <- lists:usort(Word)]).

spawn_count(Letter, Word) ->
    Parent = self(),
    spawn(fun() ->
                  Count = count_frequency(Letter, Word),
                  Parent ! {Letter, Count}
          end),
    receive
        X ->
            X
    end.

count_frequency(Letter, Word) ->
    length([ X || X <- Word, X == Letter ]).

test_version() ->
    1.
