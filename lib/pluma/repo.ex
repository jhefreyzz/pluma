defmodule Pluma.Repo do
  use Ecto.Repo,
    otp_app: :pluma,
    adapter: Ecto.Adapters.Postgres

  use Scrivener, page_size: 20

end
