defmodule BettingSystemWeb.AuthController do
  alias BettingSystem.Betting
  alias BettingSystem.Accounts
  alias BettingSystem.Repo
  alias BettingSystem.Accounts.User
  use BettingSystemWeb, :controller

  def index(conn, _params) do
    users = Repo.all(User) |> Repo.preload(:bettings)

    conn
    |> put_layout(html: :admin)
    |> render(:index, users: users)
  end

  def new(conn, _params) do
    options = [
      {"User", "user"},  # For 0, label it as "X"
      {"Admin", "admin"},  # For 1, label it as "1"
      {"Superuser", "superuser"}   # For 2, label it as "2"
    ]

    changeset = BettingSystem.Accounts.User.registration_changeset(%BettingSystem.Accounts.User{}, %{})

    conn
    |> put_layout(html: :admin)
    |> render(:create, changeset: changeset, options: options)
  end

  def show(conn, %{"id" => id}) do

    changeset = BettingSystem.Accounts.User.changeset(%BettingSystem.Accounts.User{}, %{})
    user = Repo.get(User, id)
    bettings = Betting.get_betting_by_user(user.id)
    conn
    |> put_layout(html: :admin)
    |> render(:show, user: user, changeset: changeset, bettings: bettings)
  end

  def edit(conn, %{"id" => id}) do
    user = Repo.get(User, id)
    changeset = BettingSystem.Accounts.User.changeset(%BettingSystem.Accounts.User{}, %{})

    results = [
      {"User", "user"},  # For 0, label it as "X"
      {"Admin", "admin"},  # For 1, label it as "1"
      {"Superuser", "superuser"}   # For 2, label it as "2"
    ]
    conn
    |> put_layout(html: :admin)
    |> render(:edit, user: user, changeset: changeset, results: results)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Repo.get!(User, id)
    case User.changeset(user, user_params) |> Repo.update() do
      {:ok, _user} ->
        conn
        |> put_flash(:info, "User updated successfully!")
        |> redirect(to: "/auths")

        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, :new, changeset: changeset)
    end
  end
  def create(conn, %{"user" => user_params}) do
    options = [
      {"User", "user"},  # For 0, label it as "X"
      {"Admin", "admin"},  # For 1, label it as "1"
      {"Superuser", "superuser"}   # For 2, label it as "2"
    ]
    case Accounts.register_user(user_params) do
      {:ok, user} ->
        {:ok, _} =
          Accounts.deliver_user_confirmation_instructions(
            user,
            &url(~p"/users/confirm/#{&1}")
          )

        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: "/auths")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :create, changeset: changeset, options: options)
    end
  end

  def delete(conn, %{"id" => user_id}) do
    user = Repo.get(User, user_id)

    case user do
      nil ->
        conn
        |> put_flash(:error, "User not found.")
        |> redirect(to: "/auths")

      user ->
        # Check if deleted_at is already set
        deleted_at = if user.deleted_at, do: nil, else: NaiveDateTime.utc_now()

        # Update the user with the new deleted_at value
        user
        |> User.changeset(%{deleted_at: deleted_at})
        |> Repo.update()

        conn
        |> put_flash(:info, "User status successfully updated.")
        |> redirect(to: "/auths")
    end
  end
end
