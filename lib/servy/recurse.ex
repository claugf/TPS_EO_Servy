defmodule Servy.Recurse do
  def loopy([head | tail]) do
    IO.puts("Head: #{head} Tail: #{inspect(tail)}")
    loopy(tail)
  end

  def loopy([]), do: IO.puts("Done!")

  def sum([head | tail], total) do
    IO.puts("Head: #{head} Tail: #{inspect(tail)}")
    sum(tail, total + head)
  end

  def sum([], total), do: IO.puts("Sum: #{total}")

  # This is a comun way to make a recursive function to triple a list
  def triple([head | tail]) do
    IO.puts("Head: #{head} Tail: #{inspect(tail)}")
    [head * 3 | triple(tail)]
  end

  def triple([]), do: []

  # This is taking advantage of the tail-call optimization way to make a recursive function to triple a list
  def optimized_triple(list) do
    optimized_triple(list, [])
  end

  defp optimized_triple([head | tail], triple_list) do
    optimized_triple(tail, [head * 3 | triple_list])
  end

  defp optimized_triple([], triple_list) do
    triple_list |> Enum.reverse()
  end
end

alias Servy.Recurse
Recurse.loopy([1, 2, 3, 4, 5])
Recurse.sum([1, 2, 3, 4, 5], 0)
IO.inspect(Recurse.triple([1, 2, 3, 4, 5]))
IO.inspect(Recurse.optimized_triple([1, 2, 3, 4, 5]))
