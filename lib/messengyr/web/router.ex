# lib/messengyr/web/router.ex

defmodule Messengyr.Web.Router do
  use Messengyr.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Messengyr.Web do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    
    get "/signup", PageController, :signup
    get "/login", PageController, :login

    post "/signup", PageController, :create_user
  end

  # Other scopes may use custom stacks.
  # scope "/api", Messengyr.Web do
  #   pipe_through :api
  # end
end
