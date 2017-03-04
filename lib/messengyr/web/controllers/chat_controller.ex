# lib/messengyr/web/controllers/chat_controller.ex

defmodule Messengyr.Web.ChatController do
  use Messengyr.Web, :controller

  # Add this line:
  plug Guardian.Plug.EnsureAuthenticated, handler: __MODULE__

  def index(conn, _params) do
    render conn
  end

  # Add this function:
  def unauthenticated(conn, _params) do
    conn
    |> put_flash(:error, "You need to log in to view your messages.")
    |> redirect(to: "/")
  end

end
