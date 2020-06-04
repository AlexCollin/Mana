defmodule Core.Accounts.Account do
  use Ecto.Schema
  import Ecto.Changeset

  schema "accounts" do
    field :phone, :string
    field :state, :string, default: "created"
    field :username, :string, default: ""
    field :error, :string, default: ""
    field :api_id, :string
    field :api_hash, :string
    field :is_enable, :boolean, default: false
    field :is_working, :boolean, default: false
    field :pid, :integer, default: 0
    field :verify_at, :naive_datetime
    field :active_at, :naive_datetime

    belongs_to :user, Core.Users.User

    timestamps()
  end

  @phone ~r/^\+\d{1,2}?\d{3}?\d{3}\d{4}$/


  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:phone, :api_id, :api_hash, :user_id])
    |> validate_required([:phone, :api_id, :api_hash])
    |> validate_format(:phone, @phone, message: "must be as +70000000000")
  end

  def changeset_assoc(%Core.Accounts.Account{} = account, attrs) do
    account
    |> changeset(attrs)
    |> cast_assoc(:user, required: false)
  end

end
