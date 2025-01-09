defmodule Hangman.WAMP do
  @moduledoc """
  Documentation for `Hangman.WAMP`.
  """
  require Logger
  alias Hangman.Service, as: NodeService
  alias Hangman.WAMP.CloakVault

  # @spec new_game :: Type.game()
  def new_game(kwargs, details) do
    game = NodeService.new_game() |> encrypt()
    {:ok, [game], kwargs, details}
  end

  # @spec make_move(Type.game(), String.t()) :: Type.tally()
  def make_move(game, guess, kwargs, details) do
    with {:ok, pid} <- game |> decrypt(),
         tally <- NodeService.make_move(pid, guess) do
      {:ok, [tally], kwargs, details}
    else
      {:error, key, details} ->
        {:error, "com.hangman.game.#{key}", [game], kwargs, details}
    end
  end

  # @spec tally(Type.game()) :: Type.tally()
  @spec tally(any(), any(), any()) :: :wamp_client_peer.result() | :wamp_client_peer.error()
  def tally(game, kwargs, details) do
    with {:ok, pid} <- game |> decrypt(),
         tally <- NodeService.tally(pid) do
      {:ok, [tally], kwargs, details}
    else
      {:error, key, details} ->
        {:error, "com.hangman.game.#{key}", [game], kwargs, details}
    end
  end

  def encrypt(game_pid) do
    game_pid
    |> inspect()
    |> Poison.encode!()
    |> CloakVault.encrypt!()
    |> Base.url_encode64(padding: false)
  end

  @doc """
  Decodes a base64 string into an invitation struct.
  """
  def decrypt(game_pid_str) do
    Logger.debug("decrypting #{inspect(game_pid_str)}")

    with {:ok, bin} <- Base.url_decode64(game_pid_str, padding: false),
         {:ok, decrypted} <- CloakVault.decrypt(bin),
         {:ok, decoded} <- Poison.decode(decrypted),
         pid when is_pid(pid) <- decoded |> IEx.Helpers.pid() do
      Logger.debug("Decrypted game pid: #{inspect(decoded)}")
      {:ok, pid}
    else
      _ ->
        details = %{
          code: :invalid_game,
          message: "Invalid game value",
          details: "Could not recover game"
        }

        {:error, :validation_error, details}
    end
  end
end
