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
    current_user = conn.assigns.current_user
    existing_bet =
      BettingSystem.Betting.get_betting_by_user_and_game(current_user.id, id)
    changeset = BettingSystem.Betting.changeset(%BettingSystem.Betting{}, %{})
    game = Repo.get(Game, id)
    conn
    |> put_layout(html: :admin)
    |> render(:show, game: game, changeset: changeset, existing_bet: existing_bet)
  end
end
