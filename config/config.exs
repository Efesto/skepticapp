# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :skepticapp,
  ecto_repos: [Skepticapp.Repo]

# Configures the endpoint
config :skepticapp, Skepticapp.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "lrmeZ3f4X8laN17tbR8RQtpVnM55uZj4M60PmPh/9e1ZznvwUS7ksM/7R/abaGLr",
  render_errors: [view: Skepticapp.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Skepticapp.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

config :skepticapp, :twitter_api_module, ExTwitter
config :skepticapp, :topic, "Matteo Salvini"

import_config "#{Mix.env()}.secret.exs"
