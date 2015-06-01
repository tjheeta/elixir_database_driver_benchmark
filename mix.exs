defmodule DbBench.Mixfile do
  use Mix.Project

  def project do
    [app: :db_bench,
     version: "0.0.1",
     elixir: "~> 1.0",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:logger, :exsync, :maru],
    mod: { DbBench, []} ]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [
      {:maru, "~> 0.2.9"},
      {:eredis, "~> 1.0.7"},
      {:uuid, "~> 1.0.0"},
      #{:ecto, "~> 0.12-rc"},
      {:ecto, github: "tjheeta/ecto", branch: "mysqlex_conversion"},
      {:postgrex, "~> 0.8.1"},
      {:mysql, github: "mysql-otp/mysql-otp", tag: "1.0.0" , override: true},
      #{:mariaex, github: "xerions/mariaex"},
      {:poolboy, "~> 1.5.1", [optional: false, hex: :poolboy, override: true]},
      {:mariaex, "~> 0.1.6"},
      {:epg_pool, github: "tjheeta/epg_pool"},
      {:exprof, "~> 0.2.0"}, 
      {:dbg, github: "fishcakez/dbg"},
      {:recon, github: "ferd/recon"},
      {:mysql_poolboy, github: "mysql-otp/mysql-otp-poolboy"},
      {:mydsl, github: "falood/mydsl"},
      {:mysqlex, "~> 0.0.1"},
      {:exsync, "~> 0.0.3", only: :dev}
    ]
  end
end
