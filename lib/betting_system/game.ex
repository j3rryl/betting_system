  defmodule BettingSystem.Game do
    alias BettingSystem.Repo
  use Ecto.Schema
  import Ecto.Changeset

  schema "games" do
    field :name, :string
    field :win_odds, :float
    field :loss_odds, :float
    field :draw_odds, :float
    field :result, :integer
    field :expires_at, :utc_datetime

    belongs_to :sport, BettingSystem.Sport
    has_many :bettings, BettingSystem.Betting

    timestamps()
  end

  def changeset(game, attrs) do
    game
    |> cast(attrs, [:name, :sport_id, :win_odds, :draw_odds, :loss_odds, :result, :expires_at])
    |> validate_required([:name, :sport_id, :win_odds, :draw_odds, :loss_odds, :result, :expires_at])
    |> assoc_constraint(:sport)
  end
  def create_game(attrs \\ %{}) do
    %BettingSystem.Game{}
    |> BettingSystem.Game.changeset(attrs)
    |> Repo.insert()
  end
end
