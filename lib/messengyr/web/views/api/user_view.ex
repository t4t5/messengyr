# lib/mesengyr/web/views/api/user_view.ex

defmodule Messengyr.Web.UserView do
  use Messengyr.Web, :view

  def render("show.json", %{user: user}) do
    %{
      user: user_json(user)
    }
  end

  defp user_json(user) do
    hash_email = :crypto.hash(:md5, user.email) |> Base.encode16 |> String.downcase 
    avatar_url = "http://www.gravatar.com/avatar/#{hash_email}"

    %{
      id: user.id,
      username: user.username,
      avatarURL: avatar_url,
    }
  end
end
