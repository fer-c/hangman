# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of the Config module.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
import Config

config :logger,
  backends: [:console],
  colors: [enabled: false],
  level: :error

config :lager,
  colored: false,
  level: :error,
  handlers: [
    lager_console_backend: [level: :error]
  ]

  config :awre, :erlbin_number, 15

  config :wamp_client, :peers, %{
    magenta: %{
      router: :bondy,
      pool_size: 3,
      pool_type: :hash
    }
  }
