defmodule Core.Users.User do

  use Ecto.Schema
  import Ecto.Changeset
  import Comeonin.Bcrypt, only: [hashpwsalt: 1]

  schema "users" do
    field :email, :string
    field :password_digest, :string

    timestamps()

    belongs_to :role, Core.Role

    # Virtual Fields
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
  end

  @spec changeset(
          {map, map} | %{:__struct__ => atom | %{__changeset__: map}, optional(atom) => any},
          :invalid | %{optional(:__struct__) => none, optional(atom | binary) => any}
        ) :: Ecto.Changeset.t()
  @doc false
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:email, :password, :password_confirmation, :role_id])
    |> validate_required([:email, :password, :password_confirmation, :role_id])
    |> hash_password
  end

  # def changeset(user, attrs) do
  #   user
  #   |> cast(attrs, [:email, :password, :password_confirmation, :role_id])
  #   |> validate_required([:email, :password, :password_confirmation, :role_id])
  # end

  defp hash_password(changeset) do
    if password = get_change(changeset, :password) do
      changeset
      |> put_change(:password_digest, hashpwsalt(password))
    else
      changeset
    end
  end
end
