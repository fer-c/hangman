defmodule Hangman.Service do
  @moduledoc """
  Documentation for `Hangman.Service`.
  """
  alias Hangman.Domain, as: Type
  alias Hangman.Service.Application, as: ServiceApplication

  @spec new_game :: Type.game()
  def new_game do
    {:ok, pid} = ServiceApplication.start_game()
    pid
  end

  @spec make_move(Type.game(), String.t()) :: Type.tally()
  def make_move(game, guess) do
    GenServer.call(game, {:make_move, guess})
  end

  @spec tally(Type.game()) :: Type.tally()
  def tally(game) do
    GenServer.call(game, {:tally})
  end
end
