defmodule BattleshipWeb.PlayerChannel do
  use BattleshipWeb, :channel
 
  alias Battleship.GameAgent
  alias Battleship.Chat
  alias Battleship.Game
  alias Battleship.Player

  def join("game:" <> game_code, _payload, socket) do
    chat = Chat.new()
    game = GameAgent.get(game_code) || Game.new(chat)
    GameAgent.put(game_code, game)
    socket = socket
    |> assign(:code, game_code)
    |> assign(:game, game)
    {:ok, game, socket} 
  end

  def handle_in("new_player", %{"user_name" => name}, socket) do
    code = socket.assigns[:code]
    state = GameAgent.get(code)
    game = Game.new_player(state, name)
    if !game.in_game && game.player1 != nil && game.player2 != nil do
      game = Map.put(game, :in_game, true)
    end
    GameAgent.put(code, game)
    socket = socket
    |> assign(:player, name)
    broadcast socket, "state_update", game
    {:reply, {:ok, game}, socket}
  end

  def handle_in("new_message", %{"message" => text}, socket) do
    code = socket.assigns[:code]
    state = GameAgent.get(code)
    user = socket.assigns[:player]
    game = Game.new_message(state, user, text)
    GameAgent.put(code, game)
    broadcast socket, "state_update", game
    {:reply, {:ok, game}, socket}
  end
end
