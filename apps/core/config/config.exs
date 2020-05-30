use Mix.Config

config :core, ecto_repos: [Core.Repo]

config :core,
  namespace: Core,
  pubsub_server: Core.PubSub

import_config "#{Mix.env}.exs"
