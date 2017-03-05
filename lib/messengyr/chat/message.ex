# lib/messengyr/chat/message.ex

defmodule Messengyr.Chat.Message do
  use Ecto.Schema

  alias Messengyr.Chat.Room
  alias Messengyr.Accounts.User
  
  schema "messages" do
    field :text, :string
    belongs_to :room, Room
    belongs_to :user, User

    timestamps()
  end
end
