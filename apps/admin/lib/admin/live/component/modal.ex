defmodule Admin.ComponentLive.Modal do
  use Phoenix.LiveComponent

  @defaults %{
    state: "CLOSED",
    action: nil,
    title: "Modal title",
    open_button: true,
    open_button_class: "btn btn-primary btn-round btn-fab",
    open_button_text: "",
    cancel_button: false,
    cancel_button_text: "Cancel",
    cancel_button_action: nil,
    cancel_button_param: nil,
    submit_button: false,
    submit_button_text: "OK",
    submit_button_action: nil,
    submit_button_param: nil
  }

  def mount(assigns, socket) do
    {:ok, assign(socket, Map.merge(@defaults, assigns))}
  end

  def update(assigns, socket) do
    {:ok, assign(socket, Map.merge(@defaults, assigns))}
  end

  @spec render(any) :: Phoenix.LiveView.Rendered.t()
  def render(assigns) do
      ~L"""
      <%= if @open_button do %>
        <button class="<%= @open_button_class %>" data-toggle="modal" data-target="#modal_<%= @id %>">
          <i class="material-icons">add</i> <%= @open_button_text %>
        </button>
      <% end %>
      <div class="modal fade" phx-hook="InitModal" id="modal_<%= @id %>" tabindex="-1" role="dialog" aria-labelledby="modal_<%= @id %>" aria-hidden="true">
        <div class="modal-dialog" role="document">
          <div class="modal-content">
            <div class="modal-header">
              <%= if @title != nil do %>
                <h5 class="modal-title" id="<%= @id %>_title" ><%= @title %></h5>
              <% end %>
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
              </button>
            </div>
            <div class="modal-body">
              <!-- CONTENT -->
              <%= @inner_content.([]) %>
            </div>
            <div class="modal-footer">
              <%= if @cancel_button do %>
                <button
                  type="button"
                  class="btn btn-secondary"
                  data-dismiss="modal"
                  phx-click="cancel-button-click"
                  phx-target="#modal_<%= @id %>"
                ><%= @cancel_button_text %></button>
              <% end %>
              <%= if @submit_button do %>
                <button
                  type="button"
                  class="btn btn-primary"
                  phx-click="submit-button-click"
                  phx-target="#modal_<%= @id %>"
                ><%= @submit_button_text %></button>
              <% end %>
            </div>
          </div>
        </div>
      </div>
      """
  end

  def handle_event("cancel-button-click", _params,
      %{
          assigns: %{
            cancel_button_action: cancel_button_action,
            cancel_button_param: cancel_button_param
          }
        } = socket
      ) do
    send(self(),{__MODULE__,:button_clicked,%{action: cancel_button_action, param: cancel_button_param}})

    {:noreply, socket}
  end

  def handle_event("submit-button-click",_params,
      %{
          assigns: %{
            submit_button_action: submit_button_action,
            submit_button_param: submit_button_param
          }
        } = socket
      ) do
    send(self(),{__MODULE__,:button_clicked,%{action: submit_button_action, param: submit_button_param}})

    {:noreply, socket}
  end

  # def handle_info(
  #     {Admin.ComponentLive.Modal,
  #     :button_clicked,
  #     %{action: "crash", param: exception}},
  #     socket
  #   ) do
  # raise(exception)
  #   {:noreply, socket}
  # end

end
