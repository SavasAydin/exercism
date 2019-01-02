-module(rna_transcription).
-export([to_rna/1,
	 test_version/0]).

to_rna(Dna) ->
    [ dna_to_rna(N) || N <- Dna ].

dna_to_rna(Nucleotide) ->
    proplists:get_value(Nucleotide, dna_to_rna_map()).

dna_to_rna_map() ->
    [{$G, $C},
     {$C, $G},
     {$T, $A},
     {$A, $U}].

test_version() ->
    1.