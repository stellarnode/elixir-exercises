defmodule Sequence.Server do
  use GenServer

  # external APIs

  def start_link(state \\ 0) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def next_number do
    GenServer.call __MODULE__, :next_number
  end

  def increment_number(delta) do
    GenServer.cast __MODULE__, {:increment_number, delta}
  end

  def current_state do
    GenServer.call __MODULE__, :current_state
  end

  def set_stack(stack) do
    GenServer.call __MODULE__, {:set_stack, stack}
  end

  def factors(n) do
    GenServer.call __MODULE__, {:factors, n}
  end

  def pop do
    GenServer.call __MODULE__, :pop
  end

  def push(n) do
    GenServer.cast __MODULE__, {:push, n}
  end

  def stop do
    System.halt(0)
  end

  def infinity do
    GenServer.cast __MODULE__, :infinity
  end


  # handle calls

  def handle_call(:next_number, _from, current_number) when is_integer(current_number) or is_float(current_number)  do
    { :reply, current_number + 1, current_number + 1 }
  end

  def handle_call(:next_number, _from, current) when is_list(current) do
    next = Enum.sum(current) + 1
    { :reply, next, next } 
  end

  def handle_call({:set_number, new_number}, _from, _current_number) do
    { :reply, new_number, new_number }
  end

  def handle_call({:factors, number}, _, _) do
    { :reply, {:factors_of, number, _factors(number)}, [] }
  end

  def handle_call({:set_stack, stack}, _, _) when is_list(stack) do
    { :reply, stack, stack }
  end

  def handle_call({:set_stack, stack}, _, _) do
    { :reply, [stack], [stack] }
  end

  def handle_call(:pop, _from, [head | tail ]) do
    { :reply, head, tail }
  end

  def handle_call(:pop, _from, []) do
    { :reply, [], [] }
  end

  def handle_call(:pop, _from, current_state) do
    { :reply, current_state, current_state }
  end

  def handle_call(:current_state, _from, state) do
    { :reply, state, state }
  end

  defp _factors(n) do
    for x <- 1..abs(n), rem(n, x) == 0, do: x
  end

  # handle casts (no replies)

  def handle_cast({:increment_number, delta}, current_number) do
    { :noreply, current_number + delta }
  end

  def handle_cast({:push, el}, current_stack) when is_list(current_stack) do
    { :noreply, [ el | current_stack ] }
  end

  def handle_cast({:push, el}, current_state) do
    { :noreply, [ el, current_state ] }
  end

  def handle_cast(:infinity, _) do
    raise "infinity cast"
  end

  # handle terminate

  def terminate(reason, state) do
    IO.puts "Sequence.Server teminated."
    IO.puts "Reason: #{inspect reason}"
    IO.puts "State: #{inspect state}"
  end

end
