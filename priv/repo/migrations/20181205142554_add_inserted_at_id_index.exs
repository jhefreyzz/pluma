defmodule Pluma.Repo.Migrations.AddInsertedAtIdIndex do
  use Ecto.Migration

  def change do
      create index(:posts, [:inserted_at, :id])
  end
end
