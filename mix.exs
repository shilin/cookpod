defmodule Cookpod.MixProject do
  use Mix.Project

  def project do
    [
      app: :cookpod,
      version: "0.1.0",
      elixir: "~> 1.5",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers() ++ [:phoenix_swagger],
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      elixirc_options: [warnings_as_errors: true],
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: ["coveralls.json": :test]
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Cookpod.Application, []},
      extra_applications: [:logger, :runtime_tools, :arc_ecto]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.4.17"},
      {:phoenix_pubsub, "~> 1.1"},
      {:phoenix_ecto, "~> 4.0"},
      {:ecto_sql, "~> 3.1"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix_html, "~> 2.11"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:gettext, "~> 0.11"},
      {:jason, "~> 1.0"},
      {:plug_cowboy, "~> 2.0"},
      {:excoveralls, "~> 0.10", only: :test},
      {:phoenix_slime, "~> 0.13.1"},
      {:basic_auth, "~> 2.2.2"},
      {:argon2_elixir, "~> 2.3"},
      {:arc, "~> 0.11.0"},
      {:ex_aws, "~> 2.0"},
      {:ex_aws_s3, "~> 2.0"},
      {:hackney, "~> 1.6"},
      {:poison, "~> 3.1"},
      {:sweet_xml, "~> 0.6"},
      {:arc_ecto, "~> 0.11.3"},
      {:phoenix_swagger, "~> 0.8"},
      {:ex_json_schema, "~> 0.5"},
      {:ex_machina, "~> 2.4", only: :test},
      {:quick_alias, "~> 0.1.0"},
      {:broadway_kafka, "~> 0.1.1"},
      {:recon, "~> 2.5"},
      {:telemetry_poller, "~> 0.4"},
      {:telemetry_metrics, "~> 0.4"},
      {:telemetry_metrics_prometheus, "~> 0.5"},
      {:phoenix_live_dashboard, "~> 0.1"},
      {:phoenix_live_view, "~> 0.12"},
      {:floki, ">= 0.0.0", only: :test}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
