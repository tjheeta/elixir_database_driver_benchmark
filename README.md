Code to produce driver benchmarks:

http://tjheeta.github.io/2015/05/30/benchmarking-elixir-postgres-mysql-ecto.html

* eredis (1.0.7) - 12000 qps
* mysql-otp - 10500 qps
* epgsql (git:epgsql/epgsql) - 8350 qps
* emysql (git:Eonblast/Emysql) - 7200 qps
* postgrex (0.8.1) - 5800 qps
* ecto (0.12.0-rc) with postgrex (0.8.1) - 5200 qps
* ecto (0.12.0-rc) with mariaex (0.1.6) - 500 qps
