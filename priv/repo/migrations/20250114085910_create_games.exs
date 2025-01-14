defmodule BettingSystem.Repo.Migrations.CreateGames do
  use Ecto.Migration

  def change do
    create table(:games) do
      add :name, :string, null: false
      add :sport_id, references(:sports, on_delete: :delete_all), null: false
      add :odds, :float, null: false
      add :expires_at, :utc_datetime, null: false

      timestamps()
    end

    create index(:games, [:sport_id]) # Index for faster lookups
  end
end
