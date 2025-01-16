defmodule BettingSystemWeb.GameController do
  alias BettingSystem.Sport
  alias BettingSystem.Game
  alias BettingSystem.Repo
  use BettingSystemWeb, :controller

  def index(conn, _params) do
    games = Repo.all(Game) |> Repo.preload(:sport)

    conn
    |> put_layout(html: :admin)
    |> render(:index, games: games)
  end

  def new(conn, _params) do
    sports = Repo.all(Sport)
    options = Enum.map(sports, fn sport -> {sport.name, sport.id} end)

    changeset = BettingSystem.Game.changeset(%BettingSystem.Game{}, %{})

    conn
    |> put_layout(html: :admin)
    |> render(:create, sports: sports, changeset: changeset, options: options)
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

  def edit(conn, %{"id" => id}) do
    game = Repo.get(Game, id)
    changeset = BettingSystem.Betting.changeset(%BettingSystem.Betting{}, %{})

    results = [
      {"X", "0"},  # For 0, label it as "X"
      {"1", "1"},  # For 1, label it as "1"
      {"2", "2"}   # For 2, label it as "2"
    ]
    sports = Repo.all(Sport)
    options = Enum.map(sports, fn sport -> {sport.name, sport.id} end)
    conn
    |> put_layout(html: :admin)
    |> render(:edit, game: game, changeset: changeset, options: options, results: results)
  end

  def create(conn, %{"game" => game_params}) do
    case Game.create_game(game_params) do
      {:ok, _game} ->
        conn
        |> put_flash(:info, "Game created successfully.")
        |> redirect(to: "/games")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end
end
