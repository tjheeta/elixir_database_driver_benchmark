defmodule DbBench.MariaexSupervisor do
  use Supervisor

  # this will create a linked process and call init
  def start_link do
    Supervisor.start_link(__MODULE__, [])
  end

  def init([]) do
    pool_options = [
      {:name, {:local, :mariaex_pool}},
      {:worker_module, Mariaex.Connection},
      {:size, 10},
      {:max_overflow, 10}
      ]
    mariaex_args = [
      {:hostname,"10.0.3.82"},
      {:database, "test"},
      {:username, "test"},
      {:password, "test"}
      ]

    children = [
      :poolboy.child_spec( :mariaex_pool, pool_options, mariaex_args )
      ]
    supervise(children, strategy: :one_for_one)
  end

  def q(args) do
    {:ok, item} = :poolboy.transaction(:mariaex_pool, fn(worker) -> Mariaex.Connection.query(worker, args, []) end)
  end
end
