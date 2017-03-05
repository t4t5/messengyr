# lib/messengyr/web/controllers/api/room_controller.ex

defmodule Messengyr.Web.RoomController do
  use Messengyr.Web, :controller

  alias Messengyr.Chat

  def index(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    rooms = Chat.list_rooms()

    render(conn, "index.json", %{
      rooms: rooms,
      me: user,
    })
  end

end
