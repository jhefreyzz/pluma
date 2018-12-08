defmodule Pluma.Blog.Tag do
  use Ecto.Schema
  import Ecto.Changeset


  schema "tags" do
    field :name, :string

    many_to_many :posts, Pluma.Blog.Post, join_through: Pluma.Blog.PostTag
    timestamps()
  end

  @doc false
  def changeset(tag, attrs) do
    tag
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint([:name])
  end
end
