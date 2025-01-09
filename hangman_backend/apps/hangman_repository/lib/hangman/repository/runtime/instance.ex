defmodule Hangman.Repository.Runtime.Instance do
  @moduledoc """
  Provides the single instance of the runtime repository from Server.
  """

  require Logger

  alias Hangman.Repository.Runtime.Server, as: RepositoryServer

  @behaviour Hangman.Repository.WordRepository

  @impl Hangman.Repository.WordRepository
  @spec random_word() :: String.t()
  def random_word do
    {factory, r} = RepositoryServer.get()
    Logger.debug("Using repository factory: #{inspect(factory)}")
    factory.repository().random_word(r)
  end
end
