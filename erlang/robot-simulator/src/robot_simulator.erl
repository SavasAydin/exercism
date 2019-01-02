-module(robot_simulator).
-export([create/0,
	 stop/0,
	 direction/0,
	 position/0,
	 place/2,
	 left/0,
	 right/0,
	 advance/0,
	 control/1,
	 test_version/0]).

create() ->
    Parent = self(),
    Ref = make_ref(),
    spawn(fun() ->
		  register(robot, self()),
		  Parent ! {Ref, robot_is_created},
		  Direction = undefined,
		  Position = {undefined, undefined},
		  Robot = {Direction, Position},
		  loop(Robot)
	  end),
    receive
	{Ref, robot_is_created} ->
	    ok
    end.

stop() ->
    robot_call(stop).

direction() ->
    robot_call(get_direction).

position() ->
    robot_call(get_position).

place(Direction, Position) ->
    robot_call({place, Direction, Position}).

left() ->
    robot_call(turn_left).

right() ->
    robot_call(turn_right).

advance() ->
    robot_call(move_advance).

robot_call(Message) ->
    robot ! {self(), Message},
    receive
	Response ->
	    Response
    after 10 ->
	    {error, timeout}
    end.

control(Commands) ->
    [ apply_command(C) || C <- Commands ].

apply_command($A) ->
    advance();
apply_command($L) ->
    left();
apply_command($R) ->
    right();
apply_command(_) ->
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