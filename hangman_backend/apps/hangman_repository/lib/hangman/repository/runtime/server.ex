defmodule Hangman.Repository.Runtime.Server do
  @moduledoc """
  This module provides a runtime server for the Hangman game persistence.
  """
  alias Hangman.Repository.WordRepository

  @type t :: {type :: atom(), WordRepository.t()}

  @me __MODULE__

  use Agent

  @spec start_link(list()) :: {:error, any()} | {:ok, pid()}
  def start_link(args) do
    implementation =
      Application.get_env(
        :hangman_repository,
        Hangman.Repository.Implementation,
        :in_memory
      )

    Agent.start_link(
      fn -> {implementation, implementation.new_instance(args)} end,
      name: @me
    )
  end

  @spec get() :: t()
  def get do
    Agent.get(@me, & &1)
  end
end
