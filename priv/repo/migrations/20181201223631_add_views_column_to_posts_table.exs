defmodule Pluma.Repo.Migrations.AddViewsColumnToPostsTable do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      add :views, :integer, default: 0
    end
  end
end
