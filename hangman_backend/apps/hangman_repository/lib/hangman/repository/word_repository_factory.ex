defmodule Hangman.Repository.WordRepositoryFactory do
  @moduledoc """
  Defines the Hangman.Repository.WordRepositoryFactory behaviour.
  """

  @callback repository() :: module()

  @callback new_instance(args :: list()) :: Hangman.Repository.WordRepository.t()
end
