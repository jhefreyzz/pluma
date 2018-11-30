defmodule Pluma.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :avatar_url, :string
    field :email_address, :string
    field :first_name, :string
    field :last_name, :string
    field :provider, :string
    field :token, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name, :email_address, :avatar_url, :token, :provider])
    |> validate_required([:first_name, :last_name, :email_address, :avatar_url, :token, :provider])
  end
end
