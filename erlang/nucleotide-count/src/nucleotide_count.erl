-module(nucleotide_count).
-export([count/2,
         nucleotide_counts/1,
         test_version/0]).

count(DNA, Nucleotide) ->
    case lists:member(Nucleotide, nucleotides()) of
        true ->
            length([ N || N <- DNA, [N] == Nucleotide ]);
        false ->
            erlang:error("Invalid nucleotide")
    end.

nucleotide_counts(DNA) ->
    [ {N, count(DNA, N)} || N <- nucleotides() ].

nucleotides() ->
    ["A", "T", "C", "G"].

test_version() ->
    1.