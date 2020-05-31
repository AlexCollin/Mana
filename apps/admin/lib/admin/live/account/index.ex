defmodule Admin.AccountLive.Index do
  use Admin, :live_view

  alias Core.{Accounts, Accounts.Account}

  @impl true
  def render(assigns) do
    Phoenix.View.render(Admin.AccountView, "index.html", assigns)
  end

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket), do: Accounts.subscribe()
    {:ok, assign(socket, :accounts, fetch_accounts())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Account")
    |> assign(:account, Accounts.get_account!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Account")
    |> assign(:account, %Account{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Accounts")
    |> assign(:account, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    account = Accounts.get_account!(id)
    {:ok, _} = Accounts.delete_account(account)

    {:noreply, assign(socket, :accounts, fetch_accounts())}
  end

  @impl true
  def handle_info({Accounts, [:account | _], _}, socket) do
    {:noreply, assign(socket, :accounts, fetch_accounts())}
  end

  defp fetch_accounts do
    Accounts.list_accounts()
  end

end
