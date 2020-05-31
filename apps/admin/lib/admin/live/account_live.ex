defmodule Admin.AccountLive do
  use Admin, :live_view

  alias Core.Accounts

  defp fetch(socket) do
    assign(socket,
      csrf_token: Plug.CSRFProtection.get_csrf_token(),
      accounts: Accounts.list_accounts()
    )
  end

  def render(assigns) do
    Phoenix.View.render(Admin.AccountView, "index.html", assigns)
  end

  def mount(_params, _session, socket) do
    if connected?(socket), do: Accounts.subscribe()
    {:ok, fetch(socket)}
  end

  def handle_info(event = {Accounts, [:account | _], _}, socket) do
    IO.puts("PubSub Core account: #{inspect(event)}")
    {:noreply, fetch(socket)}
  end

end
