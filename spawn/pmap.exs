defmodule Parallel do
  def pmap(collection, func) do
    me = self
    collection
      |> Enum.map(fn (el) -> 
          spawn_link fn -> (send me, {self, func.(el) }) end
         end)
      |> Enum.map(fn (pid) -> 
          receive do {^pid, result} -> result end
         end)
  end
end
