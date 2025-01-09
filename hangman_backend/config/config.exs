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

config :hangman_repository,
       Hangman.Repository.Implementation,
       Hangman.Repository.Impl.InMemoryWordRepositoryFactory

config :hangman_repository, Hangman.Repository.Runtime.Server, args: ["words.txt"]

config :hangman_service, Hangman.Repository, Hangman.Repository.Runtime.Instance

if config_env() == :test do
  config :wamp_client, start: false
end
