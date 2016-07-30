defmodule Libraries do

end

# convert float to string
IO.puts :io_lib.format("~.2f", [2.345656775])

# get value of system enviroment variables
IO.puts inspect(System.get_env())

# return extention of the file name
IO.puts Path.extname("/development/image.img")

# return the process current working directory
IO.puts System.cwd()

# convert string with JSON to Elixir data structures
# ... use Poison library

# execute shell command
System.cmd("ls", ["-la"], into: IO.stream(:stdio, :line))
