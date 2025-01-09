defmodule Hangman.Client.MixProject do
  use Mix.Project

  def project do
    [
      app: :hangman_client,
      version: "0.1.0",
      elixir: "~> 1.18",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      start_permanent: false,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
      # {:sibling_app_in_umbrella, in_umbrella: true}
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:wamp_client, git: "https://github.com/Leapsight/wamp_client.git", tag: "1.4.2", runtime: false},
      {:key_value,
       git: "https://github.com/leapsight/key_value.git",
       tag: "1.1.0",
       override: true,
       runtime: false}
    ]
  end
end
