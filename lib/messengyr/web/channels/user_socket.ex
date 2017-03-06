# lib/messengyr/web/channels/user_socket.ex

defmodule Messengyr.Web.UserSocket do
  use Phoenix.Socket

  import Messengyr.GuardianSerializer, only: [from_token: 1]

  channel "room:*", Messengyr.Web.RoomChannel
  transport :websocket, Phoenix.Transports.WebSocket

  # Use Guardian in the "connect" function:
  def connect(%{"guardianToken" => jwt}, socket) do
    with {:ok, claims} <- Guardian.decode_and_verify(jwt),
         {:ok, user} <- from_token(claims["sub"])
    do
      # Assign the user to the socket!
      {:ok, assign(socket, :current_user, user)}
    else
      _ -> :error
    end
  end

  def connect(_params, _socket) do
    :error
  end

  def id(_socket), do: nil
end
