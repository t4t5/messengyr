# lib/messengyr/web/views/error_view.ex

defmodule Messengyr.Web.ErrorView do
  use Messengyr.Web, :view

  def render("404.html", _assigns) do
    "Page not found"
  end

  def render("500.html", _assigns) do
    "Internal server error"
  end

  def render("error.json", %{message: message }) do
    %{
      error: %{
        message: message
      }
    }
  end

  # In case no render clause matches or no
  # template is found, let's render it as 500
  def template_not_found(_template, assigns) do
    render "500.html", assigns
  end
end
