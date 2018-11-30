defmodule PlumaWeb.PageController do
  use PlumaWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
