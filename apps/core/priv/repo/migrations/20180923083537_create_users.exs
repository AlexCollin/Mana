defmodule Core.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add(:email, :string, null: false)
      add(:password_digest, :string)

      timestamps()
    end

    create(unique_index(:users, ["(lower(email))"]))
  end
end
