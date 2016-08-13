defmodule MonitorTwo do
  import :timer, only: [ sleep: 1 ]

  def child(pid) do
    raise "oops..."
    send pid, {"I am going to quit..."}
    exit(:bye)
  end

  def run do
    pid = spawn_monitor(MonitorTwo, :child, [self])
    IO.puts inspect pid
    sleep 1000
    listen
  end

  def listen do
    receive do
      msg ->
        IO.puts "MESSAGE RECEIVED: #{inspect msg}"
    end
    listen
  end

end

MonitorTwo.run
