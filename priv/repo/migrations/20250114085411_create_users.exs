defmodule BettingSystem.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :first_name, :string
      add :last_name, :string
      add :email_address, :string, null: false
      add :role, :string, default: "user" # Roles: superadmin, user, admin
      add :password_hash, :string, null: false # Add the password_hash field
      add :msisdn, :string
      add :deleted_at, :utc_datetime # For soft deletes

      timestamps()
    end

    # Unique email_addresses
    create unique_index(:users, [:email_address])
  end
end
