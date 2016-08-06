defmodule EnumFunctions do

  # check if all values satisfy the condition
  def all?([], _func), do: false
  def all?([head | []], func) do
    if func.(head) do
      true
    else
      false
    end
  end
  def all?([head | tail], func) do
    if func.(head) do
      all?(tail, func)
    else
      false
    end
  end

  # check if any value satisfies the condition
  def any?([], _func), do: false
  def any?([head | tail], func) do
    if func.(head) do
      true
    else
      any?(tail, func)
    end
  end

  # filter list by condition
  def filter([], _func), do: []
  def filter(list, func) do
    for x <- list, func.(x) == true, do: x
  end

  # take first n elements of a list
  def take([], _n), do: []
  def take(_list, 0), do: []
  def take(_list, n) when n < 0, do: []
  def take([head | tail], n), do: [head | take(tail, n - 1)]

  # (not finished) splits list into two parts where the first part consists of n elements
  def split([], _n), do: {[], []}
  def split(list, 0), do: {[], list}
  def split(_list, n) when n < 0, do: []
  def split([head | tail], n) do
    {left, right} = split(tail, n - 1)
    {[head | left], right}
  end

  # flattens the list
  def flatten([]), do: []
  def flatten([head | tail]) when is_list(head), do: flatten(head) ++ flatten(tail)
  def flatten([head | tail]), do: [head | flatten(tail)]

  # create a list out of a range
  def span(a, b), do: for x <- a..b, do: x

end

IO.puts EnumFunctions.all? [1, 2, 3, 4], &(&1 < 4)

IO.puts EnumFunctions.any? [1, 2, 3, 4], &(&1 < 4)

EnumFunctions.filter([1, 8, 2, 3, 4], &(&1 < 4)) |> inspect |> IO.puts

EnumFunctions.take([1, 2, 3, 4], 2) |> inspect |> IO.puts

EnumFunctions.split([1, 2, 3, 4], 2) |> inspect |> IO.puts

EnumFunctions.flatten([[0], 1, [[3, 10], 5], 2, 3, 4]) |> inspect |> IO.puts

EnumFunctions.span(-3, 8) |> inspect |> IO.puts
