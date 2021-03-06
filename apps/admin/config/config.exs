# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :admin, Admin.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "BawUwRDJJmZbxtP2gslqTBXPCm0KbZRpRCCsDwKnQD8nTzqLjOEVA2GkHwqLlkSD",
  render_errors: [view: Admin.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Admin.PubSub,
  live_view: [signing_salt: "FsquEFxMk2X/7r9u4vqY+KJ13TiMnwaR"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :font_awesomex, helper_name: :fa_icon

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
