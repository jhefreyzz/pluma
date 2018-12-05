defmodule PlumaWeb.PostController do
  use PlumaWeb, :controller

  alias Pluma.Blog
  alias Pluma.Blog.Post

  def index(conn, _params) do
    posts = Blog.list_posts()
    render(conn, "index.html", posts: posts)
  end

  def new(conn, _params) do
    current_user = get_session(conn, :current_user)
    changeset = Blog.change_post(current_user, %Post{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"post" => post_params}) do
    current_user = get_session(conn, :current_user)
    post_params = Map.merge(%{"user" => current_user, "tags" => "erlang,elixir"}, post_params)
    case Blog.create_post(post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post created successfully.")
        |> redirect(to: Routes.post_path(conn, :show, post))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do

    post = Blog.get_post!(id)
           Blog.increment(post)
    render(conn, "show.html", post: post)
  end

  def edit(conn, %{"id" => id}) do
    post = Blog.get_post!(id)
    current_user = get_session(conn, :current_user)
    changeset = Blog.change_post(current_user, post)
    render(conn, "edit.html", post: post, changeset: changeset)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Blog.get_post!(id)
    current_user = get_session(conn, :current_user)
    post_params = Map.merge(%{"user" => current_user, "tags" => "docker, javascript" }, post_params)

    case Blog.update_post(post, post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post updated successfully.")
        |> redirect(to: Routes.post_path(conn, :show, post))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", post: post, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Blog.get_post!(id)
    {:ok, _post} = Blog.delete_post(post)

    conn
    |> put_flash(:info, "Post deleted successfully.")
    |> redirect(to: Routes.post_path(conn, :index))
  end
end
