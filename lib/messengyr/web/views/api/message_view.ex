# lib/mesengyr/web/views/api/message_view.ex

defmodule Messengyr.Web.MessageView do
  use Messengyr.Web, :view

  def render("show.json", %{message: message, me: me}) do
    %{
      message: message_json(message, %{me: me})
    }
  end

  def message_json(message, %{me: me}) do
    %{
      id: message.id,
      text: message.text,
      outgoing: outgoing?(message, me),
      sentAt: message.inserted_at,
    }
  end

  defp outgoing?(message, me) do
    message.user_id == me.id
  end
  
end
