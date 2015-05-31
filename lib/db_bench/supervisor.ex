defmodule DbBench.Supervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__,[])
  end
  def init([]) do

    # testing epgsql
    pg_pools = [
        {:main_pool,
        [size: 10, max_overflow: 10],
        [ hostname: '10.0.3.82', database: 'ecto_simple', username: 'postgres', password: 'postgres' ]
    }]
    :application.set_env(:epg_pool, :pools, pg_pools)
    :ok = :application.start(:epg_pool)

    # testing emysql
    :application.start :crypto
    :application.start :emysql
    :emysql.add_pool(:db_pool, 20, 'test', 'test', '10.0.3.82', 3306, 'test', :utf8)

    mysql_pool_options = [size: 10, max_overflow: 10]
    mysql_pool_args = [ host: '10.0.3.82', database: 'test', user: 'test', password: 'test' ]

    children = [
       worker(DbBench.RedisSupervisor,[]),
       :mysql_poolboy.child_spec(:my_pool, mysql_pool_options, mysql_pool_args),
       worker(DbBench.PostgrexSupervisor,[]),
       worker(DbBench.MysqlexSupervisor,[]),
       worker(DbBench.MariaexSupervisor,[]),
       worker(DbBench.Repo,[])
    ]
    supervise(children, strategy: :one_for_one)

  end
end

