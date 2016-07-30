defmodule FizzBuzz do
  def fb(n) do
    for x <- 1..n do
      answer(x, rem(x, 3), rem(x, 5))
    end
  end

  defp answer(n, 0, 0), do: "#{n} FizzBuzz\n"
  defp answer(n, _, 0), do: "#{n} Buzz\n"
  defp answer(n, 0, _), do: "#{n} Fizz\n"
  defp answer(n, _, _), do: "#{n}\n"
end

IO.puts FizzBuzz.fb(100)
