defmodule BettingSystemWeb.Plugs.RequireAuth do
  import Plug.Conn
  alias Phoenix.Controller
  alias BettingSystem.Repo
  alias BettingSystem.User

  def init(default), do: default

  def call(conn, _default) do
    user_id = get_session(conn, :user_id)

    if user_id && Repo.get(User, user_id) do
      conn
    else
      conn
      |> Controller.put_flash(:error, "You must be signed in to access that page.")
      |> Controller.redirect(to: "/sign_in")
      |> halt()
    end
  end
end
