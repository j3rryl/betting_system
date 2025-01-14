defmodule BettingSystem.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :first_name, :string
    field :last_name, :string
    field :email_address, :string
    field :role, :string, default: "user"
    field :msisdn, :string
    field :password, :string, virtual: true # Virtual field for password input
    field :password_hash, :string # Field for storing the hashed password
    field :deleted_at, :utc_datetime

    has_many :bettings, BettingSystem.Betting
    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name, :email_address, :role, :msisdn])
    |> validate_required([:first_name, :last_name, :email_address])
    |> unique_constraint(:email_address)
  end
end
