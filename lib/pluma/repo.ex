defmodule Pluma.Repo do
  use Ecto.Repo,
    otp_app: :pluma,
    adapter: Ecto.Adapters.Postgres
end
