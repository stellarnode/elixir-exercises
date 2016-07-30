
defmodule Chop do

  def guess(n, _s..e) when e === n do
    IO.puts "The ANSWER is #{e}"
  end

  def guess(n, s..e) when n > (s + div(e - s, 2)) do
    IO.puts "Is it #{next_guess(s, e)}?"
    guess(n, next_guess(s, e)..e)
  end

  def guess(n, s..e) do
    IO.puts "Is it #{next_guess(s, e)}?"
    guess(n, s..next_guess(s, e))
  end

  defp next_guess(s, e), do: s + div(e - s, 2)

end

IO.puts "Guessing 98 out of 1..100:"
Chop.guess(98, 1..100)

IO.puts "Guessing 37 out of 1..100:"
Chop.guess(37, 1..100)

# for x <- 1..100 do
#   IO.puts "Guessing #{x} out of 1..100:"
#   Chop.guess(x, 1..100)
# end
