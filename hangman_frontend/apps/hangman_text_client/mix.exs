defmodule Hangman.TextClient.MixProject do
  use Mix.Project

  def project do
    [
      app: :hangman_text_client,
      version: "0.1.0",
      elixir: "~> 1.18",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      start_permanent: false,
      deps: deps(),
      escript: escript()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp escript() do
    [
      main_module: Hangman.TextClient,
      name: "hangman_game",
      path: "bin/hangman"
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
      # {:sibling_app_in_umbrella, in_umbrella: true}
      {:hangman_client, in_umbrella: true},
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.29", only: :dev, runtime: false},
      {:observer_cli, "~> 1.8"},
    ]
  end
end
