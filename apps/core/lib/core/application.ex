defmodule Core.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      Core.Repo,
      Core.Telemetry,
      {Phoenix.PubSub, name: Core.PubSub}
    ]
    opts = [strategy: :one_for_one, name: Core.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
