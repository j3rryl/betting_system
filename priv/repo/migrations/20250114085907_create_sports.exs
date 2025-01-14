defmodule BettingSystem.Repo.Migrations.CreateSports do
  use Ecto.Migration

  def change do
    create table(:sports) do
      add :name, :string, null: false

      timestamps()
    end
  end
end
