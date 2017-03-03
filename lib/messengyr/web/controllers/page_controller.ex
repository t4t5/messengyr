defmodule Messengyr.Web.PageController do
  use Messengyr.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def say_hello(conn, _params) do
  	IO.inspect conn
  	text conn, "Hello!"
  end
end
