defmodule MsLoginRegistrationE.MixProject do
  use Mix.Project

  def project do
    [
      app: :ms_login_registration_e,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        "ca.release": :test,
        "ca.sobelow.sonar": :test,
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test,
        "coveralls.xml": :test,
        credo: :test,
        release: :prod,
        sobelow: :test
      ],
      releases: [
        ms_login_registration_e: [
          include_executables_for: [:unix],
          steps: [:assemble, :tar]
        ]
      ],
      metrics: false
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {MsLoginRegistrationE.Application, [Mix.env()]}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:castore, "~> 1.0"},
      {:plug_cowboy, "~> 2.7"},
      {:jason, "~> 1.4"},
      {:plug_checkup, "~> 0.6"},
      {:poison, "~> 6.0"},
      {:cors_plug, "~> 3.0"},
      {:timex, "~> 3.7"},
      # Test
      {:mock, "~> 0.3", only: :test},
      {:excoveralls, "~> 0.18", only: :test},
      # Release
      {:elixir_structure_manager, ">= 0.0.0", only: [:dev, :test]}
    ]
  end
end
