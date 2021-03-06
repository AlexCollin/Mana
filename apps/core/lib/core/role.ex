defmodule Core.Role do
  use Ecto.Schema

  import Ecto.Changeset

  schema "roles" do
    field :admin, :boolean, default: false
    field :name, :string

    has_many :users, Core.Users.User

    timestamps()
  end

  @doc false
  def changeset(role, attrs) do
    role
    |> cast(attrs, [:name, :admin])
    |> validate_required([:name, :admin])
  end
end
