# lib/messengyr/web/views/chat_view.ex

defmodule Messengyr.Web.ChatView do
  use Messengyr.Web, :view

  def jwt(conn) do
    Guardian.Plug.current_token(conn)
  end
end
