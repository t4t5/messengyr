# lib/messengyr/web/controllers/api/room_controller.ex

defmodule Messengyr.Web.RoomController do
  use Messengyr.Web, :controller

  alias Messengyr.Chat
  alias Messengyr.Web.ErrorView

  plug Guardian.Plug.EnsureAuthenticated, handler: __MODULE__

  def create(conn, %{"counterpartUsername" => counterpart_username}) do
    user = Guardian.Plug.current_resource(conn)

    with {:ok, room} <- Chat.create_room_with_counterpart(user, counterpart_username) do
      render(conn, "show.json", %{
        room: room,
        me: user,
      }) 
    end
  end

  def index(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    rooms = Chat.list_user_rooms(user)

    render(conn, "index.json", %{
      rooms: rooms,
      me: user,
    })
  end

  def unauthenticated(conn, _params) do
    conn
    |> put_status(401)
    |> render(ErrorView, "error.json", message: "You are not authenticated.")
  end

end
