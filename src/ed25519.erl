-module(ed25519).

-export([keypair/0,
	 keypair/1,
	 public_key/1,
	 sign/2,
	 sign_bytom/2,
	 verify/3]).

-type seed() :: binary().
-type signature() :: binary().
-type secret() :: binary().
-type public() :: binary().
-type message() :: binary().
-on_load(init/0).

-define(APPNAME, ed25519).
-define(LIBNAME, ed25519).

-spec keypair() -> {ok, secret(), public()} | {error, atom()}.
keypair() ->
	erlang:nif_error({error, not_loaded}).


-spec keypair(seed()) -> {ok, secret(), public()} | {error, atom()}.
keypair(_Seed) ->
	erlang:nif_error({error, not_loaded}).


-spec public_key(secret()) -> {ok, public()} | {error, atom()}.
public_key(_Secret) ->
	erlang:nif_error({error, not_loaded}).


-spec sign(message(), secret()) -> {ok, signature()}.
sign(_Message, _Secret) ->
	erlang:nif_error({error, not_loaded}).


-spec sign_bytom(message(), secret()) -> {ok, signature()}.
sign_bytom(_Message, _Secret) ->
	erlang:nif_error({error, not_loaded}).


-spec verify(signature(), message(), public()) -> {ok, atom()}.
verify(_Signature, _Message, _Public) ->
	erlang:nif_error({error, not_loaded}).




init() ->
	SoName = case code:priv_dir(?APPNAME) of
			 {error, bad_name} ->
				 case filelib:is_dir(filename:join(["..", priv])) of
					 true ->
						 filename:join(["..", priv, ?LIBNAME]);
					 _ ->
						 filename:join([priv, ?LIBNAME])
				 end;
			 Dir ->
				 filename:join(Dir, ?LIBNAME)
		 end,
	erlang:load_nif(SoName, 0).




