-module(robot_simulator).
-export([create/0,
         stop/1,
         direction/1,
         position/1,
         place/3,
         left/1,
         right/1,
         advance/1,
         control/2,
         test_version/0]).

create() ->
    Parent = self(),
    Ref = make_ref(),
    Pid = spawn(fun() ->
                        Parent ! {Ref, robot_is_created},
                        Direction = undefined,
                        Position = {undefined, undefined},
                        Robot = {Direction, Position},
                        loop(Robot)
                end),
    receive
        {Ref, robot_is_created} ->
            Pid
    end.

stop(Robot) ->
    robot_call(Robot, stop).

direction(Robot) ->
    robot_call(Robot, get_direction).

position(Robot) ->
    robot_call(Robot, get_position).

place(Robot, Direction, Position) ->
    robot_call(Robot, {place, Direction, Position}).

left(Robot) ->
    robot_call(Robot, turn_left).

right(Robot) ->
    robot_call(Robot, turn_right).

advance(Robot) ->
    robot_call(Robot, move_advance).

robot_call(Pid, Message) ->
    Pid ! {self(), Message},
    receive
        Response ->
            Response
    after 10 ->
            {error, timeout}
    end.

control(Robot, [$A | Commands]) ->
    advance(Robot),
    control(Robot, Commands);
control(Robot, [$L | Commands]) ->
    left(Robot),
    control(Robot, Commands);
control(Robot, [$R| Commands]) ->
    right(Robot),
    control(Robot, Commands);
control(_, _) ->
    do_nothing.

loop(Robot) ->
    receive
        {Pid, get_direction} ->
            Direction = element(1, Robot),
            Pid ! Direction,
            loop(Robot);
        {Pid, get_position} ->
            Position = element(2, Robot),
            Pid ! Position,
            loop(Robot);
        {Pid, {place, Direction, Position}} ->
            Pid ! placed,
            loop({Direction, Position});
        {Pid, turn_left} ->
            NewRobot = turn_left(Robot),
            Pid ! turned_left,
            loop(NewRobot);
        {Pid, turn_right} ->
            NewRobot = turn_right(Robot),
            Pid ! turned_right,
            loop(NewRobot);
        {Pid, move_advance} ->
            NewRobot = move_advance(Robot),
            Pid ! moved,
            loop(NewRobot);
        {Pid, stop} ->
            Pid ! stopped
    end.

turn_left({Direction, Position}) ->
    Dirs = directions_clockwise(),
    {NewDirection, Direction} = lists:keyfind(Direction, 2, Dirs),
    {NewDirection, Position}.

turn_right({Direction, Position}) ->
    Dirs = directions_clockwise(),
    {Direction, NewDirection} = lists:keyfind(Direction, 1, Dirs),
    {NewDirection, Position}.

directions_clockwise() ->
    [{north, east}, {east, south}, {south, west}, {west, north}].

move_advance({Direction, {X, Y}}) ->
    NewPos = proplists:get_value(Direction, [{north, {X, Y+1}},
                                             {east, {X+1, Y}},
                                             {south, {X, Y-1}},
                                             {west, {X-1, Y}}]),
    {Direction, NewPos}.

test_version() ->
    1.
