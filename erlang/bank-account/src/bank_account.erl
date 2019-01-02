-module(bank_account).

-behaviour(gen_server).

-export([create/0, balance/1, deposit/2, withdraw/2,
         charge/2, close/1, test_version/0]).
-export([start_link/0]).
-export([init/1, handle_call/3, handle_cast/2,
         handle_info/2, terminate/2, code_change/3]).

-record(state, {balance = 0}).

create() ->
    case whereis(?MODULE) of
        undefined ->
            {ok, Pid} = start_link(),
            Pid;
        AccountPid ->
            close(AccountPid),
            create()
    end.

close(AccountPid) ->
    Balance = balance(AccountPid),
    ok = gen_server:stop(AccountPid),
    Balance.

balance(AccountPid) ->
    case erlang:is_process_alive(AccountPid) of
        true ->
            gen_server:call(?MODULE, balance);
        false ->
            {error, account_closed}
    end.

deposit(_, Amount) when Amount > 0 ->
    gen_server:cast(?MODULE, {deposit, Amount});
deposit(_, _) ->
    ok.

withdraw(_, Amount) when Amount > 0 ->
    gen_server:call(?MODULE, {withdraw, Amount});
withdraw(_, _) ->
    0.

charge(_, Amount) when Amount > 0 ->
    gen_server:call(?MODULE, {charge, Amount});
charge(_, _) ->
    0.

start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

init([]) ->
    process_flag(trap_exit, true),
    {ok, #state{}}.

handle_call(balance, _, State) ->
    Reply = State#state.balance,
    {reply, Reply, State};
handle_call({withdraw, Amount}, _, State) ->
    {Taken, NewState} = handle_withdraw(Amount, State),
    {reply, Taken, NewState};
handle_call({charge, Amount}, _, State) ->
    {Taken, NewState} = handle_charge(Amount, State),
    {reply, Taken, NewState}.


handle_cast({deposit, Amount}, State) ->
    B = State#state.balance,
    NewState = State#state{balance = B + Amount},
    {noreply, NewState}.

handle_info(_Info, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

handle_withdraw(Amount, State) ->
    B = State#state.balance,
    case Amount >= B of
        true ->
            {B, #state{}};
        false ->
            NewState = State#state{balance = B - Amount},
            {Amount, NewState}
    end.

handle_charge(Amount, State) ->
    B = State#state.balance,
    case Amount >= B of
        true ->
            {0, State};
        false ->
            NewState = State#state{balance = B - Amount},
            {Amount, NewState}
    end.

test_version() ->
    1.
