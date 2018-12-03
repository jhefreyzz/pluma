defmodule Pluma.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string, null: false
      add :slug, :string
      add :content, :string, null: false
      add :is_published, :boolean, default: false, null: false
      add :user, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create index(:posts, [:user])
  end
end
