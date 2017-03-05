defmodule Messengyr.Repo.Migrations.CreateMessengyr.Chat.RoomUser do
  use Ecto.Migration

  def change do
    create table(:room_users) do
      add :room_id, references(:rooms)
      add :user_id, references(:users)

      timestamps()
    end

    create unique_index(:room_users, [:room_id, :user_id])

  end
end
