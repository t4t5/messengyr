# lib/messengyr/chat/chat.ex

defmodule Messengyr.Chat do

  alias Messengyr.Chat.{Message, Room, RoomUser}
  alias Messengyr.Repo

  import Ecto.Query

  def list_user_rooms(user) do
    query = from r in Room,
      join: u in assoc(r, :users),
      where: u.id == ^user.id

    Repo.all(query) |> Repo.preload(:messages) |> Repo.preload(:users)
  end

  def list_rooms do
    Repo.all(Room) |> Repo.preload(:messages) |> Repo.preload(:users)
  end

  def create_room() do
    room = %Room{}  
    Repo.insert(room)
  end

  def add_room_user(%{room: room, user: user}) do
    room_user = %RoomUser{
      room: room,
      user: user,
    }
    Repo.insert(room_user)
  end

  def add_message(%{room: room, user: user, text: text}) do
    message = %Message{
      room: room,
      user: user,
      text: text,
    }
    Repo.insert(message)
  end

end
