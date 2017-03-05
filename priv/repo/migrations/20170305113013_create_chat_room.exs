defmodule Messengyr.Repo.Migrations.CreateMessengyr.Chat.Room do
  use Ecto.Migration

  def change do
    create table(:rooms) do

      timestamps()
    end

  end
end
