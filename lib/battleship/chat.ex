defmodule Battleship.Chat do
  alias Battleship.Game

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

  def new_message(chat, user, message) do
    messages = [%{user: user, text: message} | Map.get(chat, "messages")]
    Map.put(chat, "messages", messages)
  end

  def new_player(chat, player) do
    players = chat["players"] ++ player
    Map.put(chat, "players", players)
  end

  def start_game(chat) do
    players = chat.players
    game = nil
    if (length(players) == 2) do
      player1 = List.first(players)
      player2 = List.last(players)
      game = Game.new(player1, player2, chat)
    end
    game
  end
end
