defmodule Admin.AccountLive.FormComponent do
  use Phoenix.LiveComponent

  def render(assigns) do
    Phoenix.View.render(Admin.AccountView, "form.html", assigns)
  end

end
