defmodule Admin.AccountLive.Components.Form do
  use Admin, :live_component

  alias Core.Accounts


  @impl true
  def render(assigns) do
    ~L"""
    <div class="card">
      <div class="card-header card-header-primary card-header-icon">
          <div class="card-icon">
          <i class="material-icons">contacts</i>
          </div>
          <h4 class="card-title">New account</h4>
      </div>
      <div class="card-body">
          <%= form_for @changeset, "#", [phx_change: :validate, phx_submit: :save, phx_target: @myself, class: 'form-horizontal'], fn f -> %>
            <div class="row">
                <%= label f, :phone, class: "col-md-3 col-form-label" %>
                <div class="col-md-9">
                  <div class="form-group has-default bmd-form-group">
                      <%= text_input f, :phone, class: "form-control", placeholder: "+7**********" %>
                      <%= error_tag f, :phone %>
                      <span class="form-control-feedback">
                          <i class="material-icons">clear</i>
                      </span>
                  </div>
                </div>
            </div>
            <div class="row">
                <%= label f, :api_id, class: "col-md-3 col-form-label" %>
                <div class="col-md-9">
                    <div class="form-group has-default bmd-form-group">
                        <%= text_input f, :api_id, class: "form-control" %>
                        <%= error_tag f, :api_id %>
                        <span class="form-control-feedback">
                            <i class="material-icons">clear</i>
                        </span>
                    </div>
                </div>
            </div>
            <div class="row">
                <%= label f, :api_hash, class: "col-md-3 col-form-label" %>
                <div class="col-md-9">
                    <div class="form-group has-default bmd-form-group">
                        <%= text_input f, :api_hash, class: "form-control" %>
                        <%= error_tag f, :api_hash %>
                        <span class="form-control-feedback">
                            <i class="material-icons">clear</i>
                        </span>
                    </div>
                </div>
            </div>
            <%= submit "Save", class: "btn btn-primary", phx_disable_with: "Saving...", disabled: !@changeset.valid? %>
          <% end %>
          </div>
      </div>
    """
  end

  @impl true
  def update(%{account: account} = assigns, socket) do
    changeset = Accounts.change_account(account)

      {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"account" => account_params}, socket) do
    changeset =
      socket.assigns.account
      |> Accounts.change_account(account_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"account" => account_params}, socket) do
    save_account(socket, socket.assigns.action, account_params)
  end

  defp save_account(socket, :edit, account_params) do
    case Accounts.update_account(socket.assigns.account, account_params) do
      {:ok, _account} ->
        {:noreply,
         socket
         |> put_flash(:info, "Account updated successfully")
         |> redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_account(socket, :new, account_params) do
    case Accounts.create_account(account_params) do
      {:ok, _account} ->
        {:noreply,
         socket
         |> put_flash(:info, "Account created successfully")
         |> redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

end
