defmodule Hangman.Client.Impl.OTP do
  @moduledoc false
  alias Hangman.Client.Type

  @behaviour Hangman.Client

  @impl Hangman.Client
  @spec new_game(list()) :: Type.game()
  def new_game([]) do
    hostname = :net_adm.localhost() |> to_string
    new_game(["hangman_game_server", hostname])
  end

  @impl Hangman.Client
  @spec new_game(list()) :: Type.game()
  def new_game([service, hostname]) do
    Node.start(String.to_atom("text_client"))
    Node.set_cookie(String.to_atom("hangman_cookie"))
    server_node = :"#{service}@#{hostname}"

    game = :rpc.call(server_node, Hangman.Service, :new_game, [])
    IO.puts("Connected to #{inspect(server_node)} from: #{inspect(Node.self)} cookie: #{inspect(Node.get_cookie)}")
    game
  end

  @impl Hangman.Client
  @spec make_move(Type.game(), String.t()) :: Type.tally()
  def make_move(game, guess) do
    GenServer.call(game, {:make_move, guess})
  end

  @impl Hangman.Client
  @spec tally(Type.game()) :: Type.tally()
  def tally(game) do
    GenServer.call(game, {:tally})
  end
end
