defmodule BattleshipWeb.Plugs do
  import Plug.Conn

  def fetch_user(conn, _opts) do
    user_name = get_session(conn, :name)
    if user_name do
      conn
      |> assign(:user_name, user_name)
    else
      conn
      |> assign(:user_name, nil)
    end
  end
end
