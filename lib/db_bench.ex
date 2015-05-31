defmodule DbBench do
  use Application

  def start(_type, _args) do
    DbBench.Supervisor.start_link
  end

end
