defmodule MariaexProfile do
  import ExProf.Macro

  @doc "analyze with profile macro"
  def do_analyze do
    c=[ hostname: "10.0.3.82", database: "test", username: "test", password: "test" ]
    {:ok, p} = Mariaex.Connection.start_link(c)
    profile do
      #:timer.sleep 2000
      #IO.puts "message\n"
      Mariaex.Connection.query(p, "SELECT id, name FROM domains")
    end
  end

  @doc "get analysis records and sum them up"
  def run do
    records = do_analyze
    total_percent = Enum.reduce(records, 0.0, &(&1.percent + &2))
    IO.inspect "total = #{total_percent}"
  end
end

