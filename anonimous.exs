defmodule Anonimous do
  def run do
    l = Enum.map [1, 2, 3, 4], &(&1 + 2)
    Enum.each l, &IO.inspect/1
  end
end

IO.puts Anonimous.run

