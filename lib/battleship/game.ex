defmodule Battleship.Game do
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

  def new_player(game, chat) do
    player = Map.get(chat, "players")
    update = Map.put(game, :chat, chat)
    if game.player1 == nil do
      update = Map.put(update, :player1, player)
    else
      update = Map.put(update, :player2, player)
    end
    update
  end


  def new_message(game, chat) do
    Map.put(game, :chat, chat)
  end

  def player_join(game, name) do
    Map.put(game, :player2, Player.new(name))
  end
end
