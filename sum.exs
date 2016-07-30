defmodule Sum do
  def all(0), do: 0
  def all(n), do: n + all(n - 1)
end

IO.puts Sum.all(3)
IO.puts Sum.all(13)

