# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :pluma,
  ecto_repos: [Pluma.Repo]

# Configures the endpoint
config :pluma, PlumaWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "+92m7z56doR6ofUwWVLhs+OJqyQnKIYpwPKblQJCBHkUNtbXUazYbym88w1ovOkL",
  render_errors: [view: PlumaWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Pluma.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :ueberauth, Ueberauth,
  providers: [
    github: { Ueberauth.Strategy.Github, [default_scope: "user,user:email,public_repo"] },
    google: { Ueberauth.Strategy.Google, []}
  ]

config :ueberauth, Ueberauth.Strategy.Github.OAuth,
  client_id: System.get_env("GITHUB_CLIENT_ID"),
  client_secret: System.get_env("GITHUB_CLIENT_SECRET")

config :ueberauth, Ueberauth.Strategy.Google.OAuth,
  client_id: System.get_env("GOOGLE_CLIENT_ID"),
  client_secret: System.get_env("GOOGLE_CLIENT_SECRET")

config :oauth2,
  serializers: %{
    "application/json" => Jason,
    "application/vnd.api+json" => Jason
  }

config :scrivener_html,
    routes_helper: PlumaWeb.Router.Helpers

config :arc,
  storage: Arc.Storage.Local,
  storage_dir: "priv/static/uploads"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
