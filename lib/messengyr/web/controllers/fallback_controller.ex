# lib/messengyr/web/controllers/fallback_controller.ex

defmodule Messengyr.Web.FallbackController do  
  use Messengyr.Web, :controller

  def call(conn, nil) do
    conn
    |> put_status(:not_found)
    |> render(Messengyr.Web.ErrorView, "error.json", message: "The resource couldn't be found!")
  end

end 
