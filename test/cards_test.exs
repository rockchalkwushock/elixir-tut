# mix test
defmodule CardsTest do
  use ExUnit.Case
  doctest Cards # will test our example code

  test "create_deck makes 52 cards" do
    deck_length = length(Cards.create_deck)
    assert deck_length == 52
  end

  test "shuffling a deck randomizes it" do
    deck = Cards.create_deck
    assert deck != Cards.shuffle(deck)
    # OR you can write the same using refute
    refute deck == Cards.shuffle(deck)  
  end
end
