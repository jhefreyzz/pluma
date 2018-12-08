defmodule Pluma.Repo.Migrations.AddPostHeaderImageFieldPostsTable do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      add :header_image, :string
    end
  end
end
