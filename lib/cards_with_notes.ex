
# This is a module
# A colleciton of different methods or functions.
defmodule Notes do
  # mix docs
  # command generates and html file for the documentation.
  # stubs out all functions for documentation as well.
  # to generate code use ``
  # to generate a code example must follow this format:
  ## Examples (must have ## space Examples)
  # must have empty line
  # must have 3 tabs over
  # code for example must start with iex>
  # must have empty line
  # """
  @moduledoc """
  Documentation for Cards.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Cards.hello
      :world

  """
  # This is a new method in the module.
  # When you call Cards.hello it will return "world".
  # iex -S mix (how to get into the shell)
  # iex = interactive elixer shell
  # iex > Cards.hello --> "world"
  # elixier has an implicit return so no need to say "return".
  # all modules & methods begin with "do" & finish with "end".
  def hello do
    :world
  end

  def create_deck do
    # iex does not recompile must use "recompile" keyword in iex.
    values = ["Ace", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Jack", "Queen", "King"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]
    # Elixir muy bueno at iterating over a collection of elements.
    # List Comprehension
    # for every element in the list DO whatever is on the inside.
    # Then return everything that has gone through the DO block as a new list.
    # inherently acts like map().
    for suit <- suits do
      suit
    end
    # Cards.create_deck()
    for value <- values do
      for suit <- suits do
        "#{value} of #{suit}" # string interpolation like ES6
      end
    end
    # nested Comprehensions are no bueno! Just like nested for loops.
    # the problem with this would be we return an array for all the Aces, Ones, etc.
    # so we get back a list of lists when we want a single list of strings.
    # One method for solving this would be to use List.flatten(deep_list)
    cards = for value <- values do
      for suit <- suits do
        "#{value} of #{suit}" # string interpolation like ES6
      end
    end
    List.flatten(cards) # returns a list of strings
    # The second method for solving this would be to pass both lists to the same
    # comprehension so they are processed at the same time.
    # You can pass multiple lists to the same comprehension.
    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end # will return a list of strings.
  end
  # Cards.shuffle() errors with Cards.shuffle/0 is undefined or private
  # This means that there is no shuffle method that accepts no args.
  # Cards.shuffle(deck) === Cards.shuffle/1 because it only accetps 1 arg.
  # This method has an arity of 1 meaning it has one argument to it.
  def shuffle(deck) do
    # Enum works with lists of data.
    # Enum is a module with many methods attached to it.
    # Enum.shuffle([list]) will return a list of shuffled enumerables.
    Enum.shuffle(deck)
    # deck = Cards.create_deck()
    # Cards.shuffle(deck)
    # Elixir is immutable!
    # The shuffle method takes in deck.
    # The list is copied.
    # The list is shuffled.
    # The list is returned.
    # deck is NEVER modified!
    # EVERY METHOD PRACTICES IMMUTABILITY!!!
  end
  # if a method will return a boolean value convetion is to end with ?.
  def contains?(deck, card) do
    # Has an arity of 2.
    # Takes a list, & value to run.
    # member? (enumerable, element) --> (list, value)
    Enum.member?(deck, card)
    # deck = Cards.create_deck()
    # Cards.contains?(deck, "Two") = true.
    # Cards.contains?(deck, "King") = false.
  end

  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
    # returns a tuple -> {[],[], etc.}
    # first element is the hand.
    # second element is the rest of the deck.
    # this is similar to JS returning an object with hand & deck as keys
    # { hand: [], deck: [] }

    # Pattern Matching in Elixir.
    # iex { hand, rest_of_deck } = Cards.deal(deck, 5)
    # iex hand -> [cards].length(5)
    # iex rest_of_deck -> [cards left in deck]
    end

    def save(deck, filename) do
      # we access erlang methods by :erlang
      # we change the deck into a binary value for saving
      # we then write a file containing the deck as binary data.
      binary = :erlang.term_to_binary(deck)
      File.write(filename, binary) # will return a file to the root directory.
    end

    def load(filename) do
      # error checking.
      # in one step we will do a comparison and assignment.
      case File.read(filename) do
        {:ok, binary } -> :erlang.binary_to_term binary # will return our array of strings.
        {:error, _reason } -> "That file does not exist!" # we know reason exists but we don't care about it.
      end
      # atom's -> :xyz
      # Think of them as strings for codefying error messages.
    end
    def create_hand(hand_size) do
      # no pipe
      deck = Cards.create_deck
      deck = Cards.shuffle(deck)
      hand = Cards.deal(deck, hand_size)
      # pipe
      # using pipe means no more storing in meaningless variables
      # pipe will pass the result of the following method as an argument
      # to the next method.
      # in the event there are multiple args pipe will pass the result of
      # the prior method as the FIRST arg.
      # to use pipe it requires that you write methods that use the
      # consistent first args.
      Cards.create_deck
      |> Cards.shuffle
      |> Cards.deal(hand_size)
    end
end
