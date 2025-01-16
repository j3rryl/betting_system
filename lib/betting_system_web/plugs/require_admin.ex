defmodule BettingSystemWeb.Plugs.RequireAdminOrSuperuser do
  import Plug.Conn
  alias BettingSystem.Accounts

  def init(default), do: default

  def call(conn, _default) do
    user = conn.assigns[:current_user] # Assuming you are assigning the user to conn in a previous plug

    if user && (user.role == "admin" or user.role == "superuser") do
      conn
    else
      conn
      |> put_flash(:error, "You do not have permission to access this page.")
      |> redirect(to: "/") # Redirect to homepage or any other page
      |> halt()
    end
  end
end
