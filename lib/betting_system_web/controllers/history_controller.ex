defmodule BettingSystemWeb.HistoryController do
  alias BettingSystem.Betting
  use BettingSystemWeb, :controller

  def index(conn, _params) do
    current_user = conn.assigns.current_user
    if current_user.role == "admin" || current_user.role == "superadmin" do
    bettings = Betting.get_bettings()
    total_lost = Enum.reduce(bettings, 0, fn betting, acc ->
      if betting.placed_bet != betting.game.result do
        acc + betting.amount
      else
        acc
      end
    end)
    conn
    |> put_layout(html: :admin)
    |> render(:index, bettings: bettings, total_lost: total_lost)
    else
    bettings = Betting.get_betting_by_user(current_user.id)
    conn
    |> put_layout(html: :admin)
    |> render(:index, bettings: bettings)
    end
  end
end
