# lib/mesengyr/web/views/api/user_view.ex

defmodule Messengyr.Web.UserView do
  use Messengyr.Web, :view

  @doc """
  Renders a user in JSON format.

  ## Example

      iex> alias Messengyr.Accounts.User
      iex> user = %User{
      ...>   id: 1,
      ...>   username: "test", 
      ...>   email: "test@example.com"
      ...> }
      iex> Messengyr.Web.UserView.render("show.json", %{user: user})
      %{
        user: %{
          id: 1, 
          username: "test", 
          avatarURL: "http://www.gravatar.com/avatar/55502f40dc8b7c769880b10874abc9d0",
        }
      }
  """
  def render("show.json", %{user: user}) do
    %{
      user: user_json(user)
    }
  end

  def user_json(%{ email: email } = user) do
    hash_email = :crypto.hash(:md5, email) |> Base.encode16 |> String.downcase 
    avatar_url = "http://www.gravatar.com/avatar/#{hash_email}"

    %{
      id: user.id,
      username: user.username,
      avatarURL: avatar_url,
    }
  end

  def user_json(user) do
    IO.inspect user

    %{
      
    }
  end
end
