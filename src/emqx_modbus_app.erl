%%%-------------------------------------------------------------------
%%% Copyright (c) 2013-2017 EMQ Enterprise, Inc. (http://emqtt.io)
%%%
%%% Licensed under the Apache License, Version 2.0 (the "License");
%%% you may not use this file except in compliance with the License.
%%% You may obtain a copy of the License at
%%%
%%%     http://www.apache.org/licenses/LICENSE-2.0
%%%
%%% Unless required by applicable law or agreed to in writing, software
%%% distributed under the License is distributed on an "AS IS" BASIS,
%%% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%%% See the License for the specific language governing permissions and
%%% limitations under the License.
%%%-------------------------------------------------------------------

-module(emqx_modbus_app).

-behaviour(application).

-include("emqx_modbus.hrl").

-export([start/2, stop/1]).

start(_Type, _Args) ->
    emqx_modbus_sup:start_link(env(company, "CompanyX"), env(device, []),
                               env(mode, 0), env(port, 502)).

env(Name, Default) ->
    application:get_env(?APP, Name, Default).

stop(_State) ->
    ok.

