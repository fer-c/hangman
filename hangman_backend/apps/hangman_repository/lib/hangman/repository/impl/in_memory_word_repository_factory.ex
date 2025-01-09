defmodule Hangman.Repository.Impl.InMemoryWordRepositoryFactory do
  @moduledoc false

  alias Hangman.Repository.Impl.InMemoryWordRepository, as: Repository

  @behaviour Hangman.Repository.WordRepositoryFactory

  @impl Hangman.Repository.WordRepositoryFactory
  @spec repository() :: module()
  def repository do
    Hangman.Repository.Impl.InMemoryWordRepository
  end

  @impl Hangman.Repository.WordRepositoryFactory
  @spec new_instance(args :: list()) :: Hangman.Repository.WordRepository.t()
  def new_instance([file_path]) do
    from_file(file_path)
  end

  @spec from_file(String.t()) :: Repository.t()
  defp from_file(file_path) do
    words =
      file_path
      |> expand_path
      |> File.read!()
      |> String.split(~r/\n/, trim: true)

    Repository.new(words)
  end

  # Expands a file path to an absolute path if it is not already.
  # iex> expand_path("words.txt")
  # "/path/to/words.txt"
  defp expand_path(file_path) do
    case String.starts_with?(file_path, ["/"]) do
      true -> file_path
      false -> Path.join([:code.priv_dir(:hangman_repository), file_path])
    end
  end
end
