# test/web/controllers/page_controller_text.exs

defmodule Messengyr.Web.PageControllerTest do
  use Messengyr.Web.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Welcome to Messengyr!"
  end
end
