defmodule BettingSystemWeb.GameController do
  alias BettingSystem.Game
  alias BettingSystem.Repo
  use BettingSystemWeb, :controller

  def index(conn, _params) do

    games = Repo.all(Game) |> Repo.preload(:sport)

    conn
    |> put_layout(html: :admin)
    |> render(:index, games: games)
  end

  def show(conn, %{"id" => id}) do
    game = Repo.get(Game, id)
    conn
    |> put_layout(html: :admin)
    |> render(:show, game: game)
  end
end
