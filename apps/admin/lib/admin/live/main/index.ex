defmodule Admin.MainLive.Index do
  use Admin, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    Phoenix.View.render(Admin.MainView, "index.html", assigns)
  end

end
