defmodule DbBench.Api do
  use Maru.Router
  #  plug Plug.Logger

  mount DbBench.Api.BenchPostgrex
  mount DbBench.Api.BenchEcto
  mount DbBench.Api.BenchEpgsql
  mount DbBench.Api.BenchEmysql
  mount DbBench.Api.BenchMysqlotp
  mount DbBench.Api.BenchMysqlex
  mount DbBench.Api.BenchRedis

  def error(conn, err) do
    "ERROR: #{inspect err}" |> text(500)
  end

end

