# lib/messengyr/accounts/session.ex

defmodule Messengyr.Accounts.Session do

  alias Messengyr.Accounts.User
  alias Messengyr.Repo

  def authenticate(%{"username" => username, "password" => given_password}) do
    user = Repo.get_by(User, username: username)

    check_password(user, given_password)
  end

  defp check_password(nil, _given_password) do
    {:error, "No user with this username was found!"}
  end

  defp check_password(%{encrypted_password: encrypted_password} = user, given_password) do
    case Comeonin.Bcrypt.checkpw(given_password, encrypted_password) do
      true -> {:ok, user}
      _    -> {:error, "Incorrect password"}
    end
  end

end
