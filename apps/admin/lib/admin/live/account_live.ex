defmodule Admin.AccountLive do
  use Phoenix.LiveView

  alias Core.Accounts
  alias Core.Accounts.Account

  def render(assigns) do
    Phoenix.View.render(Admin.AccountView, "index.html", assigns)
  end

  def mount(_params, _session, socket) do
    assigns = [
      conn: socket,
      csrf_token: Plug.CSRFProtection.get_csrf_token(),
      accounts: Accounts.list_accounts(),
    ]
    {:ok, assign(socket, assigns)}
  end

  def handle_event("validate", %{"account" => account_params}, socket) do
    changeset =
      %Account{}
      |> Accounts.change_account(account_params)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", %{"account" => account_params}, socket) do
    Accounts.create_account(account_params)
    |> case do
        {:ok, _account} ->
          live_patch(to: Routes.live_path(socket, Admin.AccountLive))
        {:error, %Ecto.Changeset{} = changeset} ->
          {:noreply, assign(socket, changeset: changeset)}
    end
  end

end
