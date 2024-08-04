-module(deploy_ffi).

-export([wait/1]).

wait(Ms) ->
  timer:sleep(Ms).
