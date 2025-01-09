defmodule Hangman.Repository.Impl.InMemoryWordRepository do
  @moduledoc """
  This module provides an in-memory persistence storage for Hangman game words.
  Words can be loaded from a file or defined at creation.
  """
  require Logger

  @type id :: integer()
  @type word :: String.t()
  @type word_list :: [word()] | []

  @type t :: %__MODULE__{
          words: word_list()
        }
  defstruct words: []

  @spec new() :: t()
  @spec new(word_list()) :: t()
  def new(words \\ []) do
    %__MODULE__{words: words}
    |> tap(&Logger.info("Loaded #{inspect(length(&1.words))} words in memory."))
  end

  @spec random_word(repository :: t()) :: String.t()
  def random_word(%__MODULE__{words: words}) do
    Enum.random(words)
  end
end
