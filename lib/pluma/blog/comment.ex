defmodule Pluma.Blog.Comment do
  use Ecto.Schema
  import Ecto.Changeset


  schema "comments" do
    field :comment, :string
    belongs_to :user, Pluma.Accounts.User
    belongs_to :post, Pluma.Blog.Post
    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:comment, :user_id, :post_id])
    |> validate_required([:comment, :user_id, :post_id])
    |> assoc_constraint(:post)
    |> assoc_constraint(:user)
  end
end
