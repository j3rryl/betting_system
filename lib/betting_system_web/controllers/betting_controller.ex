defmodule BettingSystemWeb.BettingController do
  alias BettingSystem.Game
  alias BettingSystem.Repo
  use BettingSystemWeb, :controller

  def index(conn, _params) do

    games = Repo.all(Game) |> Repo.preload(:sport)

    conn
    |> put_layout(html: :admin)
    |> render(:index, games: games)
  end

  def show(conn, _params) do
    conn
    |> put_layout(html: :admin)
    |> render(:show)
  end
end
