

defmodule DbBench.Api.BenchPostgrex do
  use Maru.Router
  version "postgrex", using: :path
  desc "get v1"
  get do
    {:ok, res } = DbBench.PostgrexSupervisor.q( "select id, name from domains ")
    "It works postgrex!" |> text
  end
end

defmodule DbBench.Api.BenchEpgsql do
  use Maru.Router
  version "epgsql", using: :path
  desc "get v1"
  get do
    res  = EpgPool.sq( "select id, name from domains ")
    "It works Epgsql" |> text
  end
end


defmodule M do
    use MyDSL, [table_name: "domains", pool: :db_pool]
end
defmodule DbBench.Api.BenchEmysql do
  use Maru.Router
  version "emysql", using: :path
  desc "get v1"
  get do
    res  = M.all()
    "It works Mysql" |> text
  end
end

defmodule DbBench.Api.BenchMysqlotp do
  use Maru.Router
  version "mysqlotp", using: :path
  desc "get v1"
  get do
    res = :mysql_poolboy.query(:my_pool, "select id,name from domains") 
    "It works Mysql-otp" |> text
  end
end

defmodule DbBench.Api.BenchEcto do
  import Ecto.Query
  use Maru.Router
  version "ecto", using: :path
  desc "get v1"
  get do
    DbBench.Repo.all(
      from d in Domain,
      select: d.name
    ) 
    "It works Ecto" |> text
  end
end

defmodule DbBench.Api.BenchRedis do
  use Maru.Router
  version "redis", using: :path
  desc "get v1"
  get do
    {:ok, res}  = DbBench.RedisSupervisor.q(["get","a"])
    "It works Redis" |> text
  end
end

