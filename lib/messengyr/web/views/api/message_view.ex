# lib/mesengyr/web/views/api/message_view.ex

defmodule Messengyr.Web.MessageView do
  use Messengyr.Web, :view

  def message_json(message, %{me: me}) do
    IO.inspect me

    %{
      id: message.id,
      text: message.text,
      sentAt: message.inserted_at,
    }
  end
end
