defmodule Ticker do

  @interval 3000 # 3 seconds
  @name :ticker

  def start do
    IO.puts "starting :generator from module #{__MODULE__}..."
    pid = spawn(__MODULE__, :generator, [[], 0])
    :global.register_name(@name, pid)
  end

  def register(client_pid) do
    send :global.whereis_name(@name), { :register, client_pid }
  end

  def generator(clients, ticks) do
    receive do
      { :register, pid } ->
        IO.puts "registering #{inspect pid}"
        generator([pid | clients], ticks)
    after @interval ->
      IO.puts "tick #{ticks}"
      case _select_client(clients, ticks) do
        { { :ok, client }, { :ok, next } } ->
          send client, { :tick, ticks, next }
        _ ->
          IO.puts "No registered clients"
      end
      generator(clients, ticks + 1)
    end
  end

  defp _select_client([], _ticks), do: nil
  defp _select_client(clients, ticks) do
    client = rem(ticks, length(clients))
    current = Enum.fetch clients, client
    next = case Enum.fetch clients, client + 1 do
      { :ok, pid } ->
        { :ok, pid }
      :error ->
        [pid | rest] = clients
        { :ok, pid }
    end
    { current, next }
  end

end


defmodule Client do

  def start do
    pid = spawn(__MODULE__, :receiver, [])
    Ticker.register(pid)
  end

  def receiver do
    receive do
      { :tick, ticks, next } ->
        send next, { :tick, ticks }
        receiver
      { :tick, ticks } ->
        IO.puts "tock in client #{inspect self} with tick #{ticks}"
        receiver
    end
  end
end
