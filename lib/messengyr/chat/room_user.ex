# lib/messengyr/chat/room_user.ex

defmodule Messengyr.Chat.RoomUser do
  use Ecto.Schema

  alias Messengyr.Chat.Room
  alias Messengyr.Accounts.User
  
  schema "room_users" do
    belongs_to :room, Room
    belongs_to :user, User

    timestamps()
  end
end
