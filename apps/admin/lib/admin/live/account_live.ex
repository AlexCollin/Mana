defmodule Admin.AccountLive do
  use Phoenix.LiveView

  def render(assigns) do
    Phoenix.View.render(Admin.AccountView, "index.html", assigns)
  end

  def mount(_params, _session, socket) do
    accounts = Core.Accounts.list_accounts()
    {:ok, assign(socket, accounts: accounts)}
  end

  def handle_event("inc", _, socket) do
    {:noreply, update(socket, :val, &(&1 + 1))}
  end

  def handle_event("dec", _, socket) do
    {:noreply, update(socket, :val, &(&1 - 1))}
  end

end
