defmodule TokenSender do
  def send_token do
    receive do
      {sender, {time, token}} ->
        send sender, {:ok, {time, token}}
        send_token
    end
  end

  def run([], []), do: IO.puts "#{inspect :os.system_time(:milli_seconds)} - all messages sent..."
  def run([pid | pids], [token | tokens]) do
    send pid, {self, {:os.system_time(:milli_seconds), token}}
    run(pids, tokens)
  end

  def create_processes(list_of_tokens) do
    pids = Enum.map list_of_tokens, fn (_) ->
      spawn(TokenSender, :send_token, [])
    end

    IO.puts "#{inspect :os.system_time(:milli_seconds)} - all processes spawned..."

    run(pids, list_of_tokens)

    IO.puts "#{inspect :os.system_time(:milli_seconds)} - now listening..."
    listen
  end

  def listen do
    receive do
      {:ok, {time, token}} ->
        IO.puts "#{inspect(time)} - received back \"#{token}\""
        listen
    end
  end

end

TokenSender.create_processes(["fred", "betty", "secret", "token"])
