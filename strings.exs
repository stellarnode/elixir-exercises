defmodule Strings do

  def is_printable(chars) do
      if Enum.any?(chars, &(&1 < 32 || &1 > 126)) do
        false
      else
        true
      end
  end

  def is_anagram(word1, word2) do
    String.reverse(_convert(word1)) == _convert(word2)
  end
  defp _convert(word) do
    word
      |> to_string
      |> String.downcase
      |> String.replace(~r/\W/, "")
  end

  @doc """
  This is a very primitive calculator. It takes a charater list (single-quoted string) as a parameter and returns the result of the calculation. This calculator does not understand negative numbers and only accepts basic operations: +, -, *, /. These operations can be applied to two number only for this exercise.

  ## Examples

    iex> String.calculate('123 + 27')
    150
  """
  def calculate(chars) do
    expr = chars
      |> to_string
      |> String.replace(~r/\s/, "")
    op = Regex.run(~r/\+|\-|\*|\//, expr)
    numbers = String.split(expr, op)
    n1 = Float.parse(hd(numbers))
    n2 = Float.parse(tl(numbers))
  end


end

Strings.is_printable('do you ever') |> IO.puts

Strings.is_anagram("do you ever", "no it's not") |> IO.puts
Strings.is_anagram('do you ever', 'no it\'s not') |> IO.puts
Strings.is_anagram("ma dam", "mad am") |> IO.puts

Strings.calculate('123 + 27') |> inspect |> IO.puts
