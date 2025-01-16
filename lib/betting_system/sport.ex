defmodule BettingSystem.Sport do
  alias BettingSystem.Repo
  use Ecto.Schema
  import Ecto.Changeset

  schema "sports" do
    field :name, :string

    has_many :games, BettingSystem.Game

    timestamps()
  end

  def changeset(sport, attrs) do
    sport
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
  def create_sport(attrs \\ %{}) do
    %BettingSystem.Sport{}
    |> BettingSystem.Sport.changeset(attrs)
    |> Repo.insert()
  end
end
