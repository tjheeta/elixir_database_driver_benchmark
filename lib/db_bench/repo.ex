defmodule DbBench.Repo do
  use Ecto.Repo, otp_app: :db_bench
end

defmodule Domain do
  use Ecto.Model
  import Ecto.Query
  schema "domains" do
    field :name, :string
  end
end
