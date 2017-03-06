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

  def handle_in("message:new", %{"text" => text, "room_id" => room_id}, socket) do
    me = socket.assigns.current_user
    room = Chat.get_room(room_id)

    with {:ok, message} <- Chat.add_message(%{
      room: room,
      user: me,
      text: text,
    }) do
      IO.puts "Added message!"

      json = %{
        messageId: message.id,
      }

      # Broadcast the ID to all the connected users of the room:
      broadcast! socket, "message:new", json

      # Return an {:ok} message to the author:
      {:reply, :ok, socket}
    else
      _ -> {:error, %{reason: "Couldn't add message!"}}
    end
  end

end
