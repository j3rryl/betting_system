defmodule BettingSystemWeb.SportController do
  alias BettingSystem.Sport
  alias BettingSystem.Repo
  use BettingSystemWeb, :controller

  def index(conn, _params) do
    sports = Repo.all(Sport)

    conn
    |> put_layout(html: :admin)
    |> render(:index, sports: sports)
  end

  def new(conn, _params) do
    changeset = BettingSystem.Sport.changeset(%BettingSystem.Sport{}, %{})

    conn
    |> put_layout(html: :admin)
    |> render(:create, changeset: changeset)
  end


  def edit(conn, %{"id" => id}) do
    sport = Repo.get(Sport, id)
    changeset = BettingSystem.Sport.changeset(%BettingSystem.Sport{}, %{})
    conn
    |> put_layout(html: :admin)
    |> render(:edit, sport: sport, changeset: changeset)
  end

  def update(conn, %{"id" => id, "sport" => sport_params}) do
    sport = Repo.get!(Sport, id)
    case Sport.changeset(sport, sport_params) |> Repo.update() do
      {:ok, _sport} ->
        conn
        |> put_flash(:info, "Sport updated successfully!")
        |> redirect(to: "/sports")

        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, :new, changeset: changeset)
    end
  end
  def create(conn, %{"sport" => sport_params}) do
    case Sport.create_sport(sport_params) do
      {:ok, _sport} ->
        conn
        |> put_flash(:info, "Sport created successfully.")
        |> redirect(to: "/sports")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end
end
