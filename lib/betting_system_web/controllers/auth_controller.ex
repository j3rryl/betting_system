defmodule BettingSystemWeb.AuthController do
  use BettingSystemWeb, :controller

  def login(conn, _params) do
    render(conn, :login)
  end

  def register(conn, _params) do
    render(conn, :register)
  end
end
