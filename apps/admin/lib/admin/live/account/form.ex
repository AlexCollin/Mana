defmodule Admin.AccountLive.Form do
  use Admin, :live_view

  alias Core.Accounts
  alias Core.Accounts.Account

  def mount(_params, %{"current_user" => _user}, socket) do
    assigns = [
      csrf_token: Plug.CSRFProtection.get_csrf_token(),
      changeset: Account.changeset(%Account{})
    ]

    {:ok, assign(socket, assigns)}
  end

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
          <%= form_for @changeset, "#", [phx_change: :validate, phx_submit: :save, class: 'form-horizontal'], fn f -> %>
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
          <%= submit "Save", class: "btn btn-primary", disabled: !@changeset.valid?, phx_disable_with: "Saving..." %>
          <% end %>
          </div>
      </div>
    """
  end

  def handle_event("validate", %{"account" => account_params}, socket) do
    changeset =
      %Account{}
      |> Accounts.change_account(account_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", %{"account" => account_params}, socket) do
    case Accounts.create_account(account_params) do
        {:ok, _account} ->
          send self(), :create_account
          {:noreply, socket}
        {:error, %Ecto.Changeset{} = changeset} ->
          {:noreply, assign(socket, changeset: changeset)}
    end
  end

  def handle_info(:create_account, socket) do
    {:noreply, socket}
  end

end
