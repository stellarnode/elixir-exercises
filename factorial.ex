defmodule Factorial do
  def of(0), do: 1
  def of(n) when n > 0, do: n * of(n - 1)
  def of(_), do: IO.puts "Only positive numbers please."
end
