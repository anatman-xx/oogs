-module(conn_client).

-behaviour(gen_fsm).

%% API
-export([start_link/0]).

%% gen_fsm callbacks
-export([init/1,
         state_name/2,
         state_name/3,
         handle_event/3,
         handle_sync_event/4,
         handle_info/3,
         terminate/3,
         code_change/4]).

-record(state, {sock}).


%%%===================================================================
%%% API
%%%===================================================================
start_link(Sock) ->
    gen_fsm:start_link({local, ?MODULE}, ?MODULE, [Sock], []).


%%%===================================================================
%%% gen_fsm callbacks
%%%===================================================================
init([Sock]) ->
    {ok, state_name, #state{sock = Sock}}.

connected(_Event, State) ->
    {next_state, state_name, State}.

lobby(_Event, State) ->
    {next_state, state_name, State}.

playing(_Event, State) ->
    {next_state, state_name, State}.

connection_lost(_Event, State) ->
    {next_state, state_name, State}.

handle_event(_Event, StateName, State) ->
    {next_state, StateName, State}.

handle_sync_event(_Event, _From, StateName, State) ->
    Reply = ok,
    {reply, Reply, StateName, State}.

handle_info(_Info, StateName, State) ->
    {next_state, StateName, State}.

terminate(_Reason, _StateName, _State) ->
    ok.

code_change(_OldVsn, StateName, State, _Extra) ->
    {ok, StateName, State}.


%%%===================================================================
%%% Internal functions
%%%===================================================================