defmodule BettingSystemWeb.HistoryController do
  use BettingSystemWeb, :controller

  def index(conn, _params) do
    conn
    |> put_layout(html: :admin)
    |> render(:index)
  end
end
