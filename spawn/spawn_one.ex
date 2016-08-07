defmodule SpawnOne do
  def greet do
    receive do
      {sender, msg} ->
        send sender, {:ok, "Hello, #{msg}"}
        greet
    end
  end
end

# here is a client
pid = spawn(SpawnOne, :greet, [])
send pid, {self, "World!"}

receive do
  {:ok, message} ->
    IO.puts message
end

send pid, {self, "my master."}

receive do
  {:ok, message} -> IO.puts message
  after 2000 -> IO.puts "The greeter has gone away"
end
