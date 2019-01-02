-module(allergies).
-export([allergies/1,
         is_allergic_to/2,
         test_version/0]).

allergies(Score) ->
    Items = items(),
    [ Allergen || {Allergen, Point} <- Items,
                  Score band Point == Point ].

is_allergic_to(Allergen, Score) ->
    lists:member(Allergen, allergies(Score)).

items() ->
    [{eggs, 1},
     {peanuts, 2},
     {shellfish, 4},
     {strawberries, 8},
     {tomatoes, 16},
     {chocolate, 32},
     {pollen, 64},
     {cats, 128}].

test_version() ->
    1.