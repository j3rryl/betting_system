defmodule BettingSystem.Repo.Migrations.CreateBetting do
  use Ecto.Migration

  def change do
    create table(:bettings) do
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :game_id, references(:games, on_delete: :delete_all), null: false
      add :amount, :float, null: false
      add :placed_bet, :integer, default: 0
      add :won, :boolean, default: false

      timestamps()
    end

    create index(:bettings, [:user_id])
    create index(:bettings, [:game_id])
  end
end
