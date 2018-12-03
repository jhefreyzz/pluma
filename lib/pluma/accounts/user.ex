defmodule Pluma.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :avatar_url, :string
    field :email_address, :string
    field :name, :string
    field :provider, :string
    field :token, :string

    has_many :posts, Pluma.Blog.Post
    timestamps()
  end

  @required_fields ~w(name email_address token provider)a
  @optional_fields ~w(avatar_url)a
  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:credentials, name: :users_email_address_provider_index)
  end

end
