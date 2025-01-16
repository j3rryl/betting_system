defmodule BettingSystemWeb.BettingController do
  alias BettingSystem.Betting
  use BettingSystemWeb, :controller

  # def create(conn, %{"betting" => betting_params}) do
  #   user_id = get_session(conn, :user_id) # Assuming the user ID is stored in the session
  #   changeset = Betting.changeset(%Betting{}, betting_params)

  #   case Repo.insert(changeset) do
  #     {:ok, _user} ->
  #       conn
  #       |> put_flash(:info, "User created successfully.")
  #       |> redirect(to: "/games")
  #     {:error, changeset} ->
  #       render(conn, "new.html", changeset: changeset)
  #   end
  # end
  def create(conn, %{"betting" => betting_params}) do
    case Betting.create_betting(betting_params) do
      {:ok, _betting} ->
        conn
        |> put_flash(:info, "Betting created successfully.")
        |> redirect(to: "/games")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end
end
