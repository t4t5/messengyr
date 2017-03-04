# lib/messengyr/web/controller/page_controller.ex

defmodule Messengyr.Web.PageController do
  use Messengyr.Web, :controller

  alias Messengyr.Accounts
  alias Messengyr.Accounts.Session

  def index(conn, _params) do
    # Add these 2 lines:
    user = Guardian.Plug.current_resource(conn)
    IO.inspect user

    render conn
  end

  def login(conn, _params) do
    render conn
  end

  def signup(conn, _params) do
    changeset = Accounts.register_changeset()

    render conn, user_changeset: changeset
  end

  def create_user(conn, %{"user" => user_params}) do
    case Accounts.create_user(user_params) do
      {:ok, _user} ->
        conn
        |> put_flash(:info, "User created successfully!")
        |> redirect(to: "/")
      {:error, user_changeset} ->
        IO.inspect user_changeset

        conn
        |> put_flash(:error, "Unable to create account!")
        |> render("signup.html", user_changeset: user_changeset)
    end
  end

  def login_user(conn, %{"credentials" => credentials}) do
    case Session.authenticate(credentials) do
      {:ok, %{username: username} = user} ->
        conn
        |> Guardian.Plug.sign_in(user) # Add this line!
        |> put_flash(:info, "Logged in as #{username}!")
        |> render("login.html")

      {:error, message} ->
        conn
        |> put_flash(:error, message)
        |> render("login.html")
    end
  end
  
end
