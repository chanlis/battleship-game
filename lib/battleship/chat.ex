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
end
