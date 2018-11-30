defmodule Pluma.Repo.Migrations.ChangeUidToStringFromUsersTable do
  use Ecto.Migration

  def change do
    alter table :users do
      modify :uid, :string, null: false
    end
  end
end
