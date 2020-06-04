defmodule Teleman.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Starts a worker by calling: Teleman.Worker.start_link(arg)
      # {Teleman.Worker, arg}
      %{
        id: Teleman,
        start: {Teleman, :start_link}
      }
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Teleman.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
