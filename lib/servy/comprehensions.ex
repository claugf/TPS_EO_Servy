defmodule Servy.Comprehensions do
  def create_a_deck(ranks, suits) do
    for rank <- ranks, suit <- suits, do: {rank, suit}
  end
end

# alias Servy.Comprehensions
# ranks = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"]
# suits = ["♣", "♦", "♥", "♠"]

# deck = Comprehensions.create_a_deck(ranks, suits) |> IO.inspect()
# _hand = deck |> Enum.shuffle() |> Enum.take(13) |> IO.inspect()
# _four_hands = deck |> Enum.shuffle() |> Enum.chunk_every(13) |> IO.inspect()
