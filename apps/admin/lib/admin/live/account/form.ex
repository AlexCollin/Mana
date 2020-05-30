defmodule Admin.AccountLive.Form do
  use Phoenix.LiveView

  alias Core.Accounts
  alias Core.Accounts.Account

  import Ecto

  def mount(_params, _session, socket) do
    assigns = [
      csrf_token: Plug.CSRFProtection.get_csrf_token(),
      changeset: Accounts.change_account(%Account{})
    ]
    {:ok, assign(socket, assigns)}
  end

  def render(assigns) do
    Phoenix.View.render(Admin.AccountView, "form.html", assigns)
  end

  def handle_event("validate", %{"account" => account_params}, socket) do
    changeset =
      %Account{}
      |> Account.changeset(account_params)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", %{"account" => account_params}, socket) do
    changeset =
      %Account{}
      |> Account.changeset(account_params)
      |> Map.put(:action, :insert)
      case Core.Repo.insert(changeset) do
        {:ok, _account} ->
          live_patch(to: Routes.live_path(socket, Admin.AccountLive))
        {:error, %Ecto.Changeset{} = changeset} ->
          {:noreply, assign(socket, changeset: changeset)}
    end
  end

end
