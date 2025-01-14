defmodule BettingSystemWeb.BettingController do
  use BettingSystemWeb, :controller

  def index(conn, _params) do
    conn
    |> put_layout(html: :admin)
    |> render(:index)
  end

  def show(conn, _params) do
    conn
    |> put_layout(html: :admin)
    |> render(:show)
  end
end
