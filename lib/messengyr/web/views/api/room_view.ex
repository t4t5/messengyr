# lib/mesengyr/web/views/api/room_view.ex

defmodule Messengyr.Web.RoomView do
  use Messengyr.Web, :view

  import Messengyr.Web.MessageView, only: [message_json: 2]
  import Messengyr.Web.UserView, only: [user_json: 1]

  def render("show.json", %{room: room, me: me}) do
    %{
      room: room_json(room, %{me: me})
    }
  end

  def render("index.json", %{rooms: rooms, me: me}) do
    %{
      rooms: Enum.map(rooms, fn(room) -> room_json(room, %{me: me}) end)
    }
  end

  defp room_json(%{users: room_users} = room, %{me: me}) do
    counterpart = get_counterpart(room_users, me)

    %{
      id: room.id,
      counterpart: user_json(counterpart),
      messages: Enum.map(room.messages, fn(message) -> message_json(message, %{me: me}) end),
      createdAt: room.inserted_at,
    }
  end

  defp get_counterpart(users, me) do
    Enum.find(users, fn(user) -> user.id != me.id end)
  end

end
