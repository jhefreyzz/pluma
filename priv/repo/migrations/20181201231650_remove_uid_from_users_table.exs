defmodule Pluma.Repo.Migrations.RemoveUidFromUsersTable do
  use Ecto.Migration

  def change do
    alter table(:users) do
      remove :uid
    end
  end
end
