defmodule LinkTwo do
  import :timer, only: [ sleep: 1 ]

  def child(pid) do
    send pid, {"I am going to quit..."}
    exit(:bye)
  end

  def run do
    pid = spawn_link(LinkTwo, :child, [self])
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

LinkTwo.run
