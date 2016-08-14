defmodule SequenceSupervisor.Server do
  use GenServer

  # external APIs

  def start_link(stash_pid \\ 0) do
    { :ok, _pid } = GenServer.start_link(__MODULE__, stash_pid, name: __MODULE__)
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

  # handle init and terminate

  def init(stash_pid) do
    current_state = SequenceSupervisor.Stash.get_value stash_pid
    { :ok, {current_state, stash_pid} }
  end

  def terminate(_reason, {current_state, stash_pid}) do
    SequenceSupervisor.Stash.save_value stash_pid, current_state
  end

  # handle calls

  def handle_call(:next_number, _from, {current_number, stash_pid}) when is_integer(current_number) or is_float(current_number)  do
    { :reply, current_number + 1, {current_number + 1, stash_pid} }
  end

  def handle_call(:next_number, _from, { current, stash_pid }) when is_list(current) do
    next = Enum.sum(current) + 1
    { :reply, next, { next, stash_pid} } 
  end

  def handle_call({:set_number, new_number}, _from, { _current_number, stash_pid }) do
    { :reply, new_number, { new_number, stash_pid } }
  end

  def handle_call({:factors, number}, _, _) do
    { :reply, {:factors_of, number, _factors(number)}, [] }
  end

  def handle_call({:set_stack, stack}, _, { _, stash_pid }) when is_list(stack) do
    { :reply, stack, { stack, stash_pid } }
  end

  def handle_call({:set_stack, stack}, _, { _, stash_pid }) do
    { :reply, [stack], { [stack], stash_pid } }
  end

  def handle_call(:pop, _from, { [head | tail ], stash_pid } ) do
    { :reply, head, { tail, stash_pid } }
  end

  def handle_call(:pop, _from, { [], stash_pid }) do
    { :reply, [], { [], stash_pid } }
  end

  def handle_call(:pop, _from, { current_state, stash_pid } ) do
    { :reply, current_state, { current_state, stash_pid } }
  end

  def handle_call(:current_state, _from, { state, stash_pid }) do
    { :reply, state, { state, stash_pid } }
  end

  defp _factors(n) do
    for x <- 1..abs(n), rem(n, x) == 0, do: x
  end

  # handle casts (no replies)

  def handle_cast({:increment_number, delta}, { current_number, stash_pid }) do
    { :noreply, { current_number + delta, stash_pid } }
  end

  def handle_cast({:push, el}, { current_stack, stash_pid } ) when is_list(current_stack) do
    { :noreply, { [ el | current_stack ], stash_pid } }
  end

  def handle_cast({:push, el}, { current_state, stash_pid }) do
    { :noreply, { [ el, current_state ], stash_pid } }
  end

  def handle_cast(:infinity, _) do
    raise "infinity cast"
  end

end
