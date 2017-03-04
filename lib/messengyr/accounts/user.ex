# lib/messengyr/accounts/user.ex

defmodule Messengyr.Accounts.User do
  use Ecto.Schema
  
  schema "users" do
    field :username, :string, unique: true
    field :email, :string, unique: true
    field :encrypted_password, :string
    field :password, :string, virtual: true

    timestamps()
  end
end
