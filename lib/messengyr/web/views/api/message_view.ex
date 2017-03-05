# lib/mesengyr/web/views/api/message_view.ex

defmodule Messengyr.Web.MessageView do
  use Messengyr.Web, :view

  # Use outgoing?/2 here...
  def message_json(message, %{me: me}) do
    %{
      id: message.id,
      text: message.text,
      outgoing: outgoing?(message, me),
      sentAt: message.inserted_at,
    }
  end

  # ...and add the function:
  defp outgoing?(message, me) do
    message.user_id == me.id
  end
  
end
