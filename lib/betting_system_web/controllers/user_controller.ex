defmodule BettingSystemWeb.UserController do
  use BettingSystemWeb, :controller

  def home(conn, _params) do
    render(conn, "index.html")
  end
end
