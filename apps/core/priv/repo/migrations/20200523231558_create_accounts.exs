defmodule Core.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
    create table(:accounts) do
      add(:phone, :string, null: false)
      add(:state, :string, null: true)
      add(:username, :string, null: true)
      add(:error, :text, null: true)
      add(:api_id, :integer, null: false)
      add(:api_hash, :string, null: false)
      add(:user_id, references(:users))
      add(:is_enable, :boolean, default: false)
      add(:is_working, :boolean, default: false)
      add(:pid, :integer, default: 0)
      add(:verify_at, :utc_datetime, null: true)
      add(:active_at, :utc_datetime, null: true)
      timestamps()
    end

    create(unique_index(:accounts, ["(lower(phone))"]))
  end
end
