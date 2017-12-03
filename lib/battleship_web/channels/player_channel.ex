defmodule BattleshipWeb.PlayerChannel do
  use BattleshipWeb, :channel
 
  alias Battleship.GameAgent
  alias Battleship.Chat
  alias Battleship.Game

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
    chat = Chat.new_player(chat, user_name)
    socket = socket
    |> assign(:user_name, user_name)
    game = socket.assigns[:game_code]
    BattleshipWeb.Endpoint.broadcast("game:" <> game, "state_update", chat)
    {:reply, {:ok, Chat.client_view(chat)}, socket}
  end

  def handle_in("new_message", %{"message" => message}, socket) do
    user = socket.assigns[:user]
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
