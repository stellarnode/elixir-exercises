defmodule Chain do

  @moduledoc """
  Run this from command line with:
    $ elixir -r chain.ex -e "Chain.run(100)"
  To run the program exceeding the system limit for the number
  of processes, run:
    $ elixir --erl "+P 1000000" -r chain.ex -e "Chain.run(400_000)"
  """

  def counter(next_pid) do
    receive do
      n -> send next_pid, n + 1
    end
  end

  def create_processes(n) do
    last = Enum.reduce 1..n, self,
                fn (_, send_to) ->
                  spawn(Chain, :counter, [send_to])
                end

    # start the count by sending
    send last, 0

    # and wait for the result to come back to us
    receive do
      final_answer when is_integer(final_answer) ->
        "Result is #{inspect(final_answer)}"
    end
  end

  def run(n) do
    IO.puts inspect :timer.tc(Chain, :create_processes, [n])
  end

end

