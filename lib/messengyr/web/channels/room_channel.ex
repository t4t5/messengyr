# lib/messengyr/web/channels/room_channel.ex

defmodule Messengyr.Web.RoomChannel do
  use Messengyr.Web, :channel

  alias Messengyr.Chat
  alias Messengyr.Chat.Room

  def join("room:" <> room_id, _payload, socket) do
    me = socket.assigns.current_user

    case Chat.get_room(room_id) do
      %Room{} = room ->
        if Chat.room_has_user?(room, me) do
          {:ok, socket}
        else
          {:error, %{reason: "You're not a member of this room!"}}
        end
      _ -> {:error, %{reason: "This room doesn't exist!"}}
    end
  end
end
