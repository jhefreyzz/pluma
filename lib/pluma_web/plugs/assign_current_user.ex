defmodule PlumaWeb.Plug.AssignCurrentUser do

  import Plug.Conn
  def init(options), do: options

  def call(conn, _params) do
    assign(conn, :current_user, get_session(conn, :current_user))
  end
end
