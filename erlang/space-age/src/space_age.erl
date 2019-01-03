-module(space_age).
-export([age/2]).

-define(EARTH_ORBITAL_PERIOD, 31557600).
-define(MERCURY_ORBITAL_PERIOD, ?EARTH_ORBITAL_PERIOD * 0.2408467).
-define(VENUS_ORBITAL_PERIOD, ?EARTH_ORBITAL_PERIOD * 0.61519726).
-define(MARS_ORBITAL_PERIOD, ?EARTH_ORBITAL_PERIOD * 1.8808158).
-define(JUPITER_ORBITAL_PERIOD, ?EARTH_ORBITAL_PERIOD * 11.862615).
-define(SATURN_ORBITAL_PERIOD, ?EARTH_ORBITAL_PERIOD * 29.447498).
-define(URANUS_ORBITAL_PERIOD, ?EARTH_ORBITAL_PERIOD * 84.016846).
-define(NEPTUNE_ORBITAL_PERIOD, ?EARTH_ORBITAL_PERIOD * 164.79132).

age(Planet, SecondsOld) ->
    OrbitalPeriod = get_orbital_period(Planet),
    SecondsOld / OrbitalPeriod.

get_orbital_period(Planet) ->
    proplists:get_value(Planet, orbital_periods()).

orbital_periods() ->
    [{earth, ?EARTH_ORBITAL_PERIOD},
     {mercury, ?MERCURY_ORBITAL_PERIOD},
     {venus, ?VENUS_ORBITAL_PERIOD},
     {mars, ?MARS_ORBITAL_PERIOD},
     {jupiter, ?JUPITER_ORBITAL_PERIOD},
     {saturn, ?SATURN_ORBITAL_PERIOD},
     {uranus, ?URANUS_ORBITAL_PERIOD},
     {neptune, ?NEPTUNE_ORBITAL_PERIOD}].
