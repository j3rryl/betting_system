defmodule BettingSystemWeb.HistoryController do
  alias BettingSystem.Betting
  use BettingSystemWeb, :controller

  def index(conn, _params) do
    current_user = conn.assigns.current_user
    bettings = Betting.get_betting_by_user(current_user.id)

    conn
    |> put_layout(html: :admin)
    |> render(:index, bettings: bettings)
  end
end
