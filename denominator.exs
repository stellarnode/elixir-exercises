
defmodule Denominator do
  def gcd(x, y) when y === 0, do: x
  def gcd(x, y), do: gcd(y, rem(x, y))
end

IO.puts Denominator.gcd(15, 30)
