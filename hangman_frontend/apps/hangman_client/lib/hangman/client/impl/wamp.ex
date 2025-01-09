defmodule Hangman.Client.Impl.WAMP do
  @moduledoc false
  alias Hangman.Client.Type

  @behaviour Hangman.Client

  @impl Hangman.Client
  @spec new_game(list()) :: Type.game()
  def new_game(_) do
    Application.ensure_all_started(:wamp_client, :permanent)
    %{hostname: hostname, port: port, realm: realm} = :wamp_client_config.get([:routers, :bondy])

    case do_wamp_call("com.hangman.game.new_game", []) do
      {:ok, [game | _], _, _} ->
        IO.puts("Connected to #{hostname}:#{port}/#{realm}")
        game

      error ->
        raise(error)
    end
  end

  @impl Hangman.Client
  @spec make_move(Type.game(), String.t()) :: Type.tally()
  def make_move(game, guess) do
    case do_wamp_call("com.hangman.game.make_move", [game, guess]) do
      {:ok, [tally | _], _, _} ->
        tally |> parse_tally
    end
  end

  @impl Hangman.Client
  @spec tally(Type.game()) :: Type.tally()
  def tally(game) do
    case do_wamp_call("com.hangman.game.tally", [game]) do
      {:ok, [tally | _], _, _} ->
        tally |> parse_tally
    end
  end

  @spec details() :: map()
  def details do
    %{}
  end

  @spec kwargs() :: map()
  def kwargs do
    %{
      "security" => %{
        "groups" => ["admin"],
        "meta" => %{
          "user_id" => "magenta_internal"
        }
      }
    }
  end

  def parse_tally(tally_map) do
    tally_map
    |> Map.new(fn {k, v} -> {String.to_atom(k), v} end)
    |> Map.update!(:game_state, fn v -> String.to_atom(v) end)
  end

  defp do_wamp_call(uri, args) do
    :wamp_client_peer.call(
      :magenta,
      uri,
      details(),
      args,
      kwargs()
    )
  end
end
