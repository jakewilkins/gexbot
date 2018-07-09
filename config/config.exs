# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :gexbot,
  ecto_repos: [Gexbot.Repo],
  webhook_secret: "supersecret"
  # webhook_secret: "abiggersupersecret"

# Configures the endpoint
config :gexbot, GexbotWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "5MwNJYqUbfXgZfJnNmQ+37RnWsXOQrI8by34URLbo+8RIQqel1nMZDGoMHepaopn",
  render_errors: [view: GexbotWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Gexbot.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :tentacat, :extra_headers, [{"Accept", "application/vnd.github.machine-man-preview+json"}]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
