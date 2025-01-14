defmodule BettingSystem.Betting do
  use Ecto.Schema
  import Ecto.Changeset

  schema "betting" do
    field :amount, :decimal
    field :won, :boolean, default: false
    field :result, :string, default: "lost"

    belongs_to :user, BettingSystem.User
    belongs_to :game, BettingSystem.Game

    timestamps()
  end

  def changeset(betting, attrs) do
    betting
    |> cast(attrs, [:user_id, :game_id, :amount, :won, :result])
    |> validate_required([:user_id, :game_id, :amount])
    |> assoc_constraint(:user)
    |> assoc_constraint(:game)
  end
end
