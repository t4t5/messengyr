# lib/messengyr/web/controllers/fallback_controller.ex

defmodule Messengyr.Web.FallbackController do  
  use Messengyr.Web, :controller

  alias Messengyr.Web.ErrorView

  def call(conn, nil) do
    conn
    |> put_status(:not_found)
    |> render(ErrorView, "error.json", message: "The resource couldn't be found!")
  end

  def call(conn, :not_allowed) do
    conn
    |> put_status(403)
    |> render(ErrorView, "error.json", message: "You're not allowed to access this resource")
  end

end 
