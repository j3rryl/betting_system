defmodule BettingSystem.Betting do
  alias BettingSystem.Repo
  use Ecto.Schema
  import Ecto.Query
  import Ecto.Changeset

  schema "bettings" do
    field :amount, :float
    field :won, :boolean, default: false
    field :placed_bet, :integer, default: 0

    belongs_to :user, BettingSystem.Accounts.User
    belongs_to :game, BettingSystem.Game

    timestamps()
  end

  def changeset(betting, attrs) do
    betting
    |> cast(attrs, [:user_id, :game_id, :amount, :won, :placed_bet])
    |> validate_required([:user_id, :game_id, :amount, :placed_bet])
    |> assoc_constraint(:user)
    |> assoc_constraint(:game)
  end

  def create_betting(attrs \\ %{}) do
    %BettingSystem.Betting{}
    |> BettingSystem.Betting.changeset(attrs)
    |> Repo.insert()
  end

  def get_betting_by_user_and_game(user_id, game_id) do
    Repo.get_by(BettingSystem.Betting, user_id: user_id, game_id: game_id)
  end
  def get_betting_by_user(user_id) do
    Repo.all(
      from b in BettingSystem.Betting,
      where: b.user_id == ^user_id,
      preload: [:game]  # Preloading the associated game details
    )
  end

end
