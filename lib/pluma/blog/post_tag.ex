defmodule Pluma.Blog.PostTag do
  use Ecto.Schema
  import Ecto.Changeset


  schema "post_tags" do
    belongs_to :post, Pluma.Blog.Post
    belongs_to :tag, Pluma.Blog.Tag

    timestamps()
  end

  @doc false
  def changeset(post_tag, attrs) do
    post_tag
    |> cast(attrs, [:post_id, :tag_id])
    |> validate_required([])
  end
end
