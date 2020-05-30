defmodule Core.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Core.Repo

  alias Core.Accounts.Account

  @topic inspect(__MODULE__)

  def subscribe do
    Phoenix.PubSub.subscribe(Core.PubSub, @topic)
  end

  def list_accounts do
    Repo.all(Account)
  end

  def get_account!(id), do: Repo.get!(Account, id)

  def create_account(attrs) do
    %Account{}
    |> Account.changeset(attrs)
    |> Repo.insert()
  end

  def update_account(%Account{} = account, attrs) do
    account
    |> Account.changeset(attrs)
    |> Repo.update()
    |> broadcast_change([:account, :updated])
  end

  def delete_account(%Account{} = account) do
    account
    |> Repo.delete
    |> broadcast_change([:account, :deleted])
  end

  def change_account(%Account{} = account, attrs \\ %{}) do
    Account.changeset(account, attrs)
  end

  def broadcast_change(result, event) do
    Phoenix.PubSub.broadcast(Core.PubSub, @topic, {__MODULE__, event, result})
    {:ok, result}
  end


end
