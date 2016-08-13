defmodule Comprehensions do
  def list(x, y) do
    for n <- x..y, do: n
  end

  def primes(n) do
    l = list(2, n)
    for x <- l, _is_prime(x), do: x
  end

  defp _is_prime(x) do
    check = for y <- 2..x, rem(x, y) == 0, do: y
    length(check) == 1
  end
end

defmodule Taxes do

  def apply(orders, taxes) do
    for [ id: id, ship_to: ship_to, net_amount: net_amount ] <- orders do
      case ship_to do
        :NC ->
          [ id: id, ship_to: ship_to, net_amount: net_amount, total_amount: net_amount * (1 + taxes[:NC]) ]
        :TX ->
          [ id: id, ship_to: ship_to, net_amount: net_amount, total_amount: net_amount * (1 + taxes[:TX]) ]
        _ ->
          [ id: id, ship_to: ship_to, net_amount: net_amount ]
      end
    end
  end

end


IO.puts inspect(Comprehensions.list(8, 19))

Comprehensions.primes(1000) |> inspect |> IO.puts

orders = [
  [ id: 123, ship_to: :NC, net_amount: 100.00 ],
  [ id: 124, ship_to: :OK, net_amount: 35.50 ],
  [ id: 125, ship_to: :TX, net_amount: 24.00 ],
  [ id: 126, ship_to: :TX, net_amount: 44.80 ],
  [ id: 127, ship_to: :NC, net_amount: 25.00 ],
  [ id: 128, ship_to: :MA, net_amount: 10.00 ],
  [ id: 129, ship_to: :CA, net_amount: 102.00 ],
  [ id: 130, ship_to: :NC, net_amount: 50.00 ]
]

tax_rates = [ NC: 0.075, TX: 0.08 ]

Taxes.apply(orders, tax_rates) |> inspect |> IO.puts
