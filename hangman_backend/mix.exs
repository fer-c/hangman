defmodule HangmanBackend.MixProject do
  use Mix.Project

  def project do
    [
      apps_path: "apps",
      version: "0.1.0",
      start_permanent: Mix.env() in [:prod, :dev],
      deps: deps(),
      # The `releases` configuration is used to define how the application
      # should be packaged and deployed. It specifies the applications
      # that should be included in the release and their start types.
      default_release: :wamp_server,
      releases: [
        # Local OTP service node
        hangman_service: [
          applications: [
            # hangman_repository is a permanent application for data access
            hangman_repository: :permanent,
            # hangman_service is a permanent application for the service component
            hangman_service: :permanent,
          ]
        ],
        # WAMP Micro Service
        wamp_server: [
          applications: [
            # hangman_repository is a permanent application for data access
            hangman_repository: :permanent,
            # hangman_service is a permanent application for the service component
            hangman_service: :permanent,
            # hangman_service is a permanent application for the service component
            hangman_wamp: :permanent
          ]
        ],
      ]
    ]
  end

  # Dependencies listed here are available only for this
  # project and cannot be accessed from applications inside
  # the apps folder.
  #
  # Run "mix help deps" for examples and options.
  defp deps do
    [
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
    ]
  end
end
