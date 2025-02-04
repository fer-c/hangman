defmodule Hangman.Repository.MixProject do
  use Mix.Project

  def project do
    [
      app: :hangman_repository,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.18",
      start_permanent: Mix.env() in [:prod, :dev],
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {Hangman.Repository.Application, []},
      extra_applications: extra_applications(Mix.env())
    ]
  end

  def extra_applications(:test), do: [:logger]
  def extra_applications(_), do: [:logger, :wx, :observer, :runtime_tools, :observer_cli]

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
      # {:sibling_app_in_umbrella, in_umbrella: true}
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.29", only: :dev, runtime: false},
      {:observer_cli, "~> 1.8"},
    ]
  end
end
