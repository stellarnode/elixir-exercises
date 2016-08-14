defmodule Dictionary do

  @name { :global, __MODULE__ }

  # External API

  def start_link do
    Agent.start_link(fn -> HashDict.new end, name: @name)
  end

  def add_words(words) do
    Agent.update(@name, &do_add_words(&1, words))
  end

  def anagram_of(word) do
    Agent.get(@name, &Dict.get(&1, signature_of(word)))
  end

  # Internal implementation

  defp do_add_words(words) do
    Enum.reduce(words, dict, &add_one_word(&1, &2))
  end

  defp add_one_word(word, dict) do
    Dict.update(dict, signature_of(word), [word], &[word | &1])
  end

  defp signature_of(word) do
    word
      |> to_char_list
      |> Enum.sort
      |> to_string
  end
end

defmodule WordlistLoader do
  def load_from_files(file_names) do
    file_names
      |> Stream.map(fn name -> Task.async(fn -> load_task(name) end) end)
      |> Enum.map(&Task.await/1)
  end

  defp load_task(file_name) do
    File.stream(file_name, [], :line)
      |> Enum.map(&String.strip/1)
      |> Dictionary.add_words
  end
end
