defmodule Pluma.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :first_name, :string, null: false, size: 40
      add :last_name, :string, null: false, size: 40
      add :email_address, :string, null: false
      add :avatar_url, :string, default: "default_avatar.png"
      add :token, :string, null: false
      add :provider, :string, null: false

      timestamps()
    end

    create unique_index(:users, [:email_address, :provider])
  end
end
