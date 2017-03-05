# lib/messengyr/web/controllers/api/user_controller.ex

defmodule Messengyr.Web.UserController do
  use Messengyr.Web, :controller

  alias Messengyr.Accounts

  action_fallback Messengyr.Web.FallbackController

  def show(conn, %{"id" => user_id}) do
    user = Accounts.get_user(user_id)

    if user do
      render(conn, "show.json", user: user)
    end
  end

end
