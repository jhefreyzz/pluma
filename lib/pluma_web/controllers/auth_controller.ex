defmodule PlumaWeb.AuthController do
  use PlumaWeb, :controller
  plug Ueberauth

  alias Pluma.Accounts

  @spec delete(Plug.Conn.t(), any()) :: Plug.Conn.t()
  def delete(conn, _params) do
    conn
    |> put_flash(:info, "You have been logged out.")
    |> configure_session(drop: true)
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    conn
    |> put_flash(:error, "Failed to authenticate")
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    user_params = user_params(auth, conn.path_params["provider"])
    IO.inspect user_params
    case Accounts.get_user_by_email_and_provider(user_params) do
      nil ->
        case Accounts.create_user(user_params) do
        {:ok, user} ->
          conn
            |> put_flash(:info, "Successfully authenticated")
            |> put_session(:current_user, user)
            |> redirect(to: "/")
       {:error, reason} ->
          conn
            |> put_flash(:error, reason)
            |> redirect(to: "/")
       end
      user ->
         conn
         |> put_flash(:info, "Successfully authenticated")
         |> put_session(:current_user, user)
         |> redirect(to: "/")
     end
  end

  defp user_params(auth, provider) do
    %{name: get_name_from_auth(auth),
      email_address: auth.info.email, avatar_url: get_avatar_from_auth(auth),
      token: auth.credentials.token, provider: provider }
  end

  defp get_avatar_from_auth(%{info: %{image: image}}), do: image
  defp get_avatar_from_auth(%{info: %{urls: %{avatar_url: image}}}), do: image

  defp get_name_from_auth(auth) do
    if auth.info.name do
      auth.info.name
    else
      name = [auth.info.first_name, auth.info.last_name]
      |> Enum.filter(&(&1 != nil && &1 != ""))

      cond do
        length(name) == 0 -> auth.info.nickname
        true -> Enum.join(name, " ")
      end
    end
  end
end
