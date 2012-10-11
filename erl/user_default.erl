%%
%% This module provides some useful functions when developing erlang.
%%
-module(user_default).
-author("harald@octris.org").
-export([reload/0]).

%%
%% Reloads all modules.
%%
reload() ->
    {ok, [[Home]]} = init:get_argument(home),
    
    Modules = [M || {M, P} <- code:all_loaded(), is_list(P) andalso string:str(P, Home) > 0], 

    [shell_default:l(M) || M <- Modules].