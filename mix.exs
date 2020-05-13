defmodule Mana.MixProject do
  use Mix.Project

  def project do
    [
      aliases: aliases(),
      apps_path: "apps",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  defp deps do
    [
      {:phoenix, "~> 1.5.1"},
      {:phoenix_html, "~> 2.14"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:phoenix_live_dashboard, "~> 0.2"},
      {:phoenix_ecto, "~> 4.1"},
      {:plug_cowboy, "~> 2.2"},
      {:ecto_sql, "~> 3.4"},
      {:postgrex, "~> 0.15"},
      {:telemetry_metrics, "~> 0.4"},
      {:telemetry_poller, "~> 0.4"},
      {:gettext, "~> 0.18"},
      {:jason, "~> 1.2"},
    ]
  end

  defp aliases do
    [
      "core.reset": ["ecto.drop", "core.setup"],
      "core.seed": "run apps/core/priv/repo/seeds.exs",
      "core.setup": ["ecto.create", "ecto.migrate", "core.seed"]
    ]
  end
end
