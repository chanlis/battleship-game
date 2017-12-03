defmodule Battleship.Game do
  alias Battleship.Player

  def new(chat_room) do
    %{
      player1: nil,
      player2: nil,
      chat: chat_room
    }
  end

  def new(player1, player2) do
    %{
      player1: player1,
      player2: player2
    }
  end

  def client_view(game) do
    %{
    }
  end

  def player_join(game, name) do
    Map.put(game, :player2, Player.new(name))
  end
end
