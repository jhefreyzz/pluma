defmodule Pluma.Blog.Post do
  use Ecto.Schema
  use Arc.Ecto.Schema
  import Ecto.Changeset


  schema "posts" do
    field :content, :string
    field :header_image, Pluma.HeaderImage.Type
    field :is_published, :boolean, default: false
    field :slug, :string
    field :title, :string
    field :views, :integer
    belongs_to :user, Pluma.Accounts.User, on_replace: :update
    many_to_many :tags, Pluma.Blog.Tag, join_through: Pluma.Blog.PostTag, on_replace: :delete
    has_many :comments, Pluma.Blog.Comment
    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :content, :is_published, :header_image])
    |> validate_required([:title, :content])
    |> put_slug()
  end

  defp put_slug(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{title: title}} -> put_change(changeset, :slug, Slugger.slugify_downcase(title))
      _ ->
        changeset
    end
  end

end
