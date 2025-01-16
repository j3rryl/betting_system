defmodule BettingSystemWeb.BettingController do
  alias BettingSystem.Repo
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

  # Action to delete a bet
  def delete(conn, %{"id" => bet_id}) do
    bet = Repo.get(Betting, bet_id)

    case bet do
      nil ->
        conn
        |> put_flash(:error, "Bet not found.")
        |> redirect(to: "/games")

      bet ->
        # Delete the bet
        Repo.delete!(bet)

        conn
        |> put_flash(:info, "Bet successfully canceled.")
        |> redirect(to: "/games")
    end
  end
end
