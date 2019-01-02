-module(scrabble_score).
-export([score/1,
	 test_version/0]).

score(Word) ->
    Str = string:to_lower(Word),
    PAndL = points_and_letters(),
    Points = [P || {P, L} <- PAndL,
		   Letter <- Str,
		   lists:member(Letter, L)],
    lists:sum(Points).

points_and_letters() ->
[{1, [$a, $e, $i, $o, $u, $l, $n, $r, $s, $t]},
 {2, [$d, $g]},
 {3, [$b, $c, $m, $p]},
 {4, [$f, $h, $v, $w, $y]},
 {5, [$k]},
 {8, [$j, $x]},
 {10, [$q, $z]}].

test_version() ->
    1.