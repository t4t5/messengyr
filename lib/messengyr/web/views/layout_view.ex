# lib/messengyr/web/views/layout_view.ex

defmodule Messengyr.Web.LayoutView do
  use Messengyr.Web, :view

  def logged_in?(conn) do
  	Guardian.Plug.authenticated?(conn)
  end

  def username(conn) do
    # We get the user:
    user = Guardian.Plug.current_resource(conn)

    # We extract the username with pattern matching:
    %{username: username} = user

    # Return the username:
    username
  end

  def avatar(conn) do
    user = Guardian.Plug.current_resource(conn)

    # We extract the email with pattern matching:
    %{email: email} = user

    # Hash the email address and make it URL-compliant:
    hash_email = :crypto.hash(:md5, email) |> Base.encode16 |> String.downcase 

    # Return the image URL:
    "http://www.gravatar.com/avatar/#{hash_email}"
  end
end
