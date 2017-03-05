defmodule Messengyr.Repo.Migrations.CreateMessengyr.Chat.Message do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :text, :string

      add :room_id, references(:rooms)
      add :user_id, references(:users)

      timestamps()
    end

  end
end
