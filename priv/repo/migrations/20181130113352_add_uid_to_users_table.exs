defmodule Pluma.Repo.Migrations.AddUidToUsersTable do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :uid, :integer, null: false
    end
      
  end
end
