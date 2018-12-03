defmodule Pluma.Repo.Migrations.ChangeUserToUserId do
  use Ecto.Migration

  def change do
    rename table(:posts), :user, to: :user_id
  end
end
