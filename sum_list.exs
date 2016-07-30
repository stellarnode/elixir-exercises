defmodule Sum do

  # sum up a list
  def list([]), do: 0
  def list([head | tail]), do: head + list(tail)
  def list, do: IO.puts "Sum.list/1 uses lists as argument"

  # map and sum up a list
  def mapsum([], _func), do: 0
  def mapsum([head | tail], func), do: func.(head) + mapsum(tail, func)

end

IO.puts Sum.list([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13])
IO.puts Sum.list([1])
IO.puts Sum.list([])

IO.puts Sum.mapsum([1, 2, 3], &(&1 * &1))
