-module(circular_buffer).
-export([create/1,
	 stop/1,
	 read/1,
	 write/2,
	 write_attempt/2,
	 size/1,
	 test_version/0]).

-record(buffer, {queue = queue:new(), size = 0, configured_size}).

create(Size) ->
    spawn(fun() -> loop(#buffer{configured_size = Size}) end).

stop(Pid) ->
    Pid ! stop.

size(Pid) ->
    buffer_call(Pid, size).

read(Pid) ->
    buffer_call(Pid, read).

write(Pid, Data) ->
    buffer_cast(Pid, {write, Data}).

write_attempt(Pid, Data) ->
    buffer_call(Pid, {write_attempt, Data}).

loop(Buffer) ->
    receive
	{Pid, Ref, size} ->
	    CS = Buffer#buffer.configured_size,
	    Pid ! {Ref, {ok, CS}},
	    loop(Buffer);
	{Pid, Ref, read} ->
	    {Reply, NewBuffer} = pop(Buffer),
	    Pid ! {Ref, Reply},
	    loop(NewBuffer);
	{write, Data} ->
	    NewBuffer = push(Data, Buffer),
	    loop(NewBuffer);
	{Pid, Ref, {write_attempt, Data}} ->
	    {Reply, NewBuffer} = try_push(Data, Buffer),
	    Pid ! {Ref, Reply},
	    loop(NewBuffer);
	stop ->
	    stopped
    end.

buffer_cast(Pid, Message) ->
    Pid ! Message.

buffer_call(Pid, Message) ->
    Parent = self(),
    Ref = make_ref(),
    Pid ! {Parent, Ref, Message},
    receive
	{Ref, X} ->
	    X
    end.

pop(Buffer) ->
    Q = Buffer#buffer.queue,
    case queue:out(Q) of
	{empty, Q} ->
	    {{error, empty}, Buffer};
	{{value, Item}, NewQ} ->
	    Size = Buffer#buffer.size,
	    NewB = Buffer#buffer{queue = NewQ, size = Size-1},
	    {{ok, Item}, NewB}
    end.

push(Data, Buffer) ->
    Q = Buffer#buffer.queue,
    case is_full(Buffer) of
	true ->
	    Size = Buffer#buffer.size,
	    NewQ = queue:in(Data, Q),
	    Buffer#buffer{queue = NewQ, size = Size+1};
	false ->
	    NewQ = queue:in(Data, queue:tail(Q)),
	    Buffer#buffer{queue = NewQ}
    end.

try_push(Data, Buffer) ->
    case is_full(Buffer) of
	true ->
	    Size = Buffer#buffer.size,
	    Q = Buffer#buffer.queue,
	    NewQ = queue:in(Data, Q),
	    NewB = Buffer#buffer{queue = NewQ, size = Size+1},
	    {ok, NewB};
	false ->
	    {{error, full}, Buffer}
    end.

is_full(Buffer) ->
    Buffer#buffer.size < Buffer#buffer.configured_size.

test_version() ->
    1.