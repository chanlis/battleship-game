defmodule Battleship.Game do
  alias Battleship.Chat
  alias Battleship.Player

  def new(chat_room) do
    %{
      player1: nil,
      player2: nil,
      chat: chat_room
    }
  end

  def new(p1, p2, c) do
    %{
      player1: p1,
      player2: p2,
      chat: c
    }
  end

  def user_exists?(state, name) do
    players = state.chat.players
    Enum.find(players, fn(p) -> p.name == name end)
  end

  def new_player(state, name) do
    if user_exists?(state, name) do
      state
    else
      chat = Chat.new_player(state, name)
      player = List.first(Map.get(chat, :players))
      game = Map.put(state, :chat, chat)
      if game.player1 == nil do
        Map.put(game, :player1, player)
      else
        Map.put(game, :player2, player)
      end
    end
  end

  def new_message(state, user, text) do
    chat = Chat.new_message(Map.get(state, :chat), user, text)
    Map.put(state, :chat, chat)
  end

  def player_join(game, name) do
    Map.put(game, :player2, Player.new(name))
  end
end
