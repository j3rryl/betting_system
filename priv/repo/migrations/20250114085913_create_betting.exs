defmodule BettingSystem.Repo.Migrations.CreateBetting do
  use Ecto.Migration

  def change do
    create table(:betting) do
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :game_id, references(:games, on_delete: :delete_all), null: false
      add :amount, :decimal, null: false, precision: 10, scale: 2
      add :won, :boolean, default: false
      add :result, :string, default: "lost" # Could also use an enum later

      timestamps()
    end

    create index(:betting, [:user_id])
    create index(:betting, [:game_id])
  end
end
