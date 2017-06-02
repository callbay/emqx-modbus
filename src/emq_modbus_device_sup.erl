%%%-----------------------------------------------------------------------------
%%% Copyright (c) 2016-2017 Feng Lee <feng@emqtt.io>, All Rights Reserved.
%%%
%%% Permission is hereby granted, free of charge, to any person obtaining a copy
%%% of this software and associated documentation files (the "Software"), to deal
%%% in the Software without restriction, including without limitation the rights
%%% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
%%% copies of the Software, and to permit persons to whom the Software is
%%% furnished to do so, subject to the following conditions:
%%%
%%% The above copyright notice and this permission notice shall be included in all
%%% copies or substantial portions of the Software.
%%%
%%% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
%%% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
%%% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
%%% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
%%% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
%%% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
%%% SOFTWARE.
%%%-----------------------------------------------------------------------------
%%% @doc
%%% interface of emqttd.
%%%
%%% @end
%%%-----------------------------------------------------------------------------
-module(emq_modbus_device_sup).

-behavior(supervisor).

-include("emq_modbus.hrl").

-export([start_link/1, init/1]).

-define(CHILD(Host, Port, Name),
        {{modbus_device, Name}, {emq_modbus_device, connect, [Host, Port, Name]},
            permanent, 5000, worker, [emq_modbus_device]}).

%% @doc Start modbus device Supervisor.
-spec(start_link(list()) -> {ok, pid()}).
start_link(DeviceList) ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, DeviceList).


init(DeviceList) ->
    Childs = [ ?CHILD(Host, Port, list_to_binary(DeviceName)) || {Host, Port, DeviceName} <- DeviceList],
    {ok, {{one_for_one, 128, 60}, Childs}}.





