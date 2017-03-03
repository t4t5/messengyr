# priv/repo/migrations/xxxx_create_user.exs

defmodule Messengyr.Repo.Migrations.CreateMessengyr.User do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string
      add :email, :string
      add :encrypted_password, :string

      timestamps()
    end

    # Add these 2 lines:
    create unique_index(:users, [:username])
    create unique_index(:users, [:email])

  end
end
