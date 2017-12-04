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

  def new_message(chat, user, message) do
    if Map.get(chat, :messages) == nil do
      messages = [%{user: user, text: message}]
    else
      messages = [%{user: user, text: message} | Map.get(chat, :messages)]
    end
    Map.put(chat, :messages, messages)
  end

  def new_player(state, name) do
    player = Player.new(name)
    chat = Map.get(state, :chat)
    players = [player | Map.get(chat, :players)]
    Map.put(chat, :players, players)
  end

  def user_exists?(name) do
  
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
