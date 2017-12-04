defmodule Battleship.Player do
  def new(user_name) do
    %{
      name: user_name,
      hits: [],
      misses: [],
      ships: []
    }
  end
end
