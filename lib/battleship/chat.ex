defmodule Battleship.Chat do
  alias Battleship.Game
  alias Battleship.Player

  def new() do
    %{
      players: [],
      messages: [],
    }
  end

  def client_view(chat) do
    %{
      players: chat["players"],
      messages: chat["messages"]
    }
  end

  def pushMessage(chat, user, message) do
    Map.put(chat, :messages, %{user: user, text: message})
  end

  def new_player(chat, name) do
    players = chat["players"] ++ Player.new(name)
    Map.put(chat, "players", name)
  end

  def start_game(chat) do
    players = chat.players
    game = nil
    if (length(players) == 2) do
      player1 = List.first(players)
      player2 = List.last(players)
      game = Game.new(player1, player2)
    end
    game
  end
end
