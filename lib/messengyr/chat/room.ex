# lib/messengyr/chat/room.ex

defmodule Messengyr.Chat.Room do
  use Ecto.Schema

  alias Messengyr.Chat.Message
  alias Messengyr.Accounts.User
  
  schema "rooms" do
    has_many :messages, Message

    # Add this line:
    many_to_many :users, User, join_through: "room_users"

    timestamps()
  end
end
