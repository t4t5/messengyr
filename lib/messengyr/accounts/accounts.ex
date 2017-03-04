# lib/messengyr/accounts/accounts.ex

defmodule Messengyr.Accounts do

  import Ecto.Changeset
  alias Messengyr.Accounts.User
  alias Messengyr.Repo

  def create_user(params) do
    register_changeset(params)
    |> Repo.insert
  end

  def register_changeset(params \\ %{}) do
    %User{}
    |> cast(params, [:username, :email, :password])
    |> validate_required([:username, :email, :password])
  end

end
