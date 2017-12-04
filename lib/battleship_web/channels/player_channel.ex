defmodule BattleshipWeb.PlayerChannel do
  use BattleshipWeb, :channel
 
  alias Battleship.GameAgent
  alias Battleship.Chat
  alias Battleship.Game
  alias Battleship.Player

  def join("game:" <> game_code, _payload, socket) do
    chat = Chat.new()
    game = Game.new(chat)
    socket = socket
    |> assign(:game, game)
    {:ok, game, socket} 
  end

  def join("player:" <> user_name, _payload, socket) do
    session = Session.new()
    socket = socket
    |> assign(:session, session)
    |> assign(:user_name, user_name)
  end

  def handle_in("new_player", %{"chat" => chat, "user_name" => user_name}, socket) do
    player = Player.new(user_name)
    chat = Chat.new_player(chat, player)
    game = Game.new_player(socket.assigns[:game], chat)
    socket = socket
    |> assign(:player, player)
    |> assign(:chat, chat)
    |> assign(:game, game)
    broadcast socket, "state_update", game
    {:reply, {:ok, game}, socket}
  end

  def handle_in("new_message", %{"message" => message}, socket) do
    user = socket.assigns[:player]
    chat = Chat.new_message(socket.assigns[:chat], user, message)
    game = Game.new_message(socket.assigns[:game], chat)
    socket = socket
    |> assign(:chat, chat)    
    |> assign(:game, game)
    broadcast socket, "state_update", game
    {:reply, {:ok, game}, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
