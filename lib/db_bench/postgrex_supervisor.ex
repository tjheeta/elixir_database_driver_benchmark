defmodule DbBench.PostgrexSupervisor do
  use Supervisor

  # this will create a linked process and call init
  def start_link do
    Supervisor.start_link(__MODULE__, [])
  end

  def init([]) do
    pool_options = [
      {:name, {:local, :postgrex_pool}},
      {:worker_module, Postgrex.Connection},
      {:size, 10},
      {:max_overflow, 10}
      ]
    postgrex_args = [
      {:hostname,"10.0.3.82"},
      {:database, String.to_char_list("ecto_simple")},
      {:username, String.to_char_list("postgres")},
      {:password, String.to_char_list("postgres")}
      ]

    children = [
      :poolboy.child_spec( :postgrex_pool, pool_options, postgrex_args )
      ]
    supervise(children, strategy: :one_for_one)
  end

  def q(args) do
    {:ok, item} = :poolboy.transaction(:postgrex_pool, fn(worker) -> Postgrex.Connection.query(worker, args, []) end)
  end
end
