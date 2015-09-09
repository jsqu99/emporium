defmodule EmporiumApi.Mixfile do
  use Mix.Project

  def project do
    [app: :emporium_api,
     version: "0.0.1",
     elixir: "~> 1.0",
     deps_path: "../../deps",
     lockfile: "../../mix.lock",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [mod: {EmporiumApi, []},
     applications: [:phoenix, :cowboy, :logger, :phoenix_html,
                    :phoenix_ecto, :postgrex]]
  end

  # Specifies which paths to compile per environment
  defp elixirc_paths(:test), do: ["lib", "web", "modules", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web", "modules"]

  # Specifies your project dependencies
  #
  # Type `mix help deps` for examples and options
  defp deps do
    [{:phoenix, "~> 1.0.2"},
     {:phoenix_ecto, "~> 1.1"},
     {:phoenix_html, "~> 2.1"},
     {:postgrex, "~> 0.9.1"},
     {:phoenix_live_reload, "~> 1.0", only: :dev},
     {:cowboy, "~> 1.0"}]
  end
end
