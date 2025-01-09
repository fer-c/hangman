defmodule Hangman.Repository.WordRepository do
  @moduledoc """
  Defines the Hangman.Repository.WordRepository behaviour.
  """

  @type t :: struct()

  @doc """
  Returns a random word from the repository.
  """
  @callback random_word() :: String.t()
end
