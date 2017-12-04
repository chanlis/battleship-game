defmodule BattleshipWeb.PageController do
  use BattleshipWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def set_name(conn, %{"name" => name}) do
    conn
    |> put_session(:name, name)
    |> redirect(to: page_path(conn, :index))
  end
end
