defmodule BettingSystemWeb.AuthController do
  use BettingSystemWeb, :controller

  def login(conn, _params) do
    conn
    |> put_layout(html: false)
    |> render(:login)
  end

  def register(conn, _params) do
    # render(conn, :register)
    conn
    |> put_layout(html: :false)
    |> render(:register)
    # conn
    # |> put_layout(html: :admin)
    # |> render(:register)
  end
end
