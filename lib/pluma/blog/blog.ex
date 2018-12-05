defmodule Pluma.Blog do
  @moduledoc """
  The Blog context.
  """
  import Ecto.Changeset
  import Ecto.Query, warn: false
  alias Pluma.Repo
  alias Pluma.Blog.Post

  @doc """
  Returns the list of posts.

  ## Examples

      iex> list_posts()
      [%Post{}, ...]

  """
  def list_posts(params) do
    # query = from(p in Post, order_by: [desc: p.inserted_at, asc: p.id], preload: [:user, :tags])
    # Repo.paginate(query, cursor_fields: [:inserted_at, :id], limit: 20)
    Post
    |> preload(:user)
    |> preload(:tags)
    |> Repo.paginate(params)
  end

  @doc """
  Gets a single post.

  Raises `Ecto.NoResultsError` if the Post does not exist.

  ## Examples

      iex> get_post!(123)
      %Post{}

      iex> get_post!(456)
      ** (Ecto.NoResultsError)

  """
  def get_post!(id), do: Repo.get!(Post, id) |> Repo.preload(:user) |> Repo.preload(:tags)

  @doc """
  Creates a post.

  ## Examples

      iex> create_post(%{field: value})
      {:ok, %Post{}}

      iex> create_post(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_post(attrs \\ %{}) do
    %Post{}
    |> Post.changeset(attrs)
    |> put_assoc(:user, attrs["user"])
    |> put_tags(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a post.

  ## Examples

      iex> update_post(post, %{field: new_value})
      {:ok, %Post{}}

      iex> update_post(post, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    |> put_tags(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Post.

  ## Examples

      iex> delete_post(post)
      {:ok, %Post{}}

      iex> delete_post(post)
      {:error, %Ecto.Changeset{}}

  """
  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking post changes.

  ## Examples

      iex> change_post(post)
      %Ecto.Changeset{source: %Post{}}

  """
  def change_post(user, post) do
    post
      |> Post.changeset(%{})
      |> put_assoc(:user, user)

  end

   def increment(post) do
     from(p in Post, where: p.id == ^post.id) |> Repo.update_all(set: [views: post.views + 1])
   end

  alias Pluma.Blog.Tag

  @doc """
  Returns the list of tags.

  ## Examples

      iex> list_tags()
      [%Tag{}, ...]

  """
  def list_tags do
    Repo.all(Tag)
  end

  @doc """
  Gets a single tag.

  Raises `Ecto.NoResultsError` if the Tag does not exist.

  ## Examples

      iex> get_tag!(123)
      %Tag{}

      iex> get_tag!(456)
      ** (Ecto.NoResultsError)

  """
  def get_tag!(id), do: Repo.get!(Tag, id)

  @doc """
  Creates a tag.

  ## Examples

      iex> create_tag(%{field: value})
      {:ok, %Tag{}}

      iex> create_tag(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_tag(attrs \\ %{}) do
    %Tag{}
    |> Tag.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a tag.

  ## Examples

      iex> update_tag(tag, %{field: new_value})
      {:ok, %Tag{}}

      iex> update_tag(tag, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_tag(%Tag{} = tag, attrs) do
    tag
    |> Tag.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Tag.

  ## Examples

      iex> delete_tag(tag)
      {:ok, %Tag{}}

      iex> delete_tag(tag)
      {:error, %Ecto.Changeset{}}

  """
  def delete_tag(%Tag{} = tag) do
    Repo.delete(tag)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking tag changes.

  ## Examples

      iex> change_tag(tag)
      %Ecto.Changeset{source: %Tag{}}

  """
  def change_tag(%Tag{} = tag) do
    Tag.changeset(tag, %{})
  end

  defp put_tags(post, attrs) do
    put_assoc(post, :tags, parse_tags(attrs))
  end

  defp parse_tags(attrs) do
   (attrs["tags"] || attrs[:tags] || "")
   |> String.split(",")
   |> Enum.map(&String.trim/1)
   |> Enum.reject(& &1 == "")
   |> insert_and_get_all()
 end

 defp insert_and_get_all([]), do: []
 defp insert_and_get_all(names) do
   now = NaiveDateTime.utc_now |> NaiveDateTime.truncate(:second)
   maps = Enum.map(names, &%{name: &1, inserted_at: now, updated_at: now})
   Repo.insert_all Tag, maps, on_conflict: :nothing
   Repo.all from t in Tag, where: t.name in ^names
 end

end
