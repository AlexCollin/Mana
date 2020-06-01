defmodule Admin.ComponentLive.Modal do
  use Admin, :live_component

  @defaults %{
    title: nil,
    buttons: []
  }

  @impl true
  def mount(socket) do
    {:ok, assign(socket, @defaults)}
  end

  @impl true
  def render(assigns) do
      ~L"""
        <div class="modal fade"
          id="modal_<%= @id %>"
          tabindex="-1"
          role="dialog"
          aria-labelledby="modal_<%= @id %>"
          aria-hidden="true"
          phx-hook="InitModal"
          phx-capture-click="close"
          phx-window-keydown="close"
          phx-key="escape"
          phx-target="#modal_<%= @id %>"
          phx-page-loading
        >
          <div class="modal-dialog" role="document">
            <div class="modal-content">
              <div class="modal-header">
                <%= if @title != nil do %>
                  <h5 class="modal-title" id="<%= @id %>_title" ><%= @title %></h5>
                <% end %>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <%= live_patch raw("&times;"), to: @return_to, class: "close" %>
                </button>
              </div>
              <div class="modal-body">
                  <%= live_component @socket, @component, @opts %>
              </div>
              <div class="modal-footer">
                <%= for button <- @buttons do %>
                    <button
                      type="button"
                      <%= if button[:class] != nil do %>
                        class="btn <%= button[:class] %>"
                        <% else %>
                        class="btn btn-primary btn-round btn-fab"
                      <% end %>
                      <%= if button[:dismiss] != nil do %>
                        data-dismiss="modal"
                      <% end %>
                      <%= if button[:click] != nil do %>
                        phx-click="<%= button[:click] %>"
                      <% end %>
                      <%= if button[:target] != nil do %>
                        phx-target="<%= button[:target] %>"
                      <% end %>
                    >
                    <%= button[:text] %>
                    </button>
                <% end %>
              </div>
            </div>
          </div>
        </div>
      """
  end

  @impl true
  def handle_event("close", _, socket) do
    {:noreply, push_patch(socket, to: socket.assigns.return_to)}
  end
  # def handle_event("cancel-button-click", _params,
  #     %{
  #         assigns: %{
  #           cancel_button_action: cancel_button_action,
  #           cancel_button_param: cancel_button_param
  #         }
  #       } = socket
  #     ) do
  #   send(self(),{__MODULE__,:button_clicked,%{action: cancel_button_action, param: cancel_button_param}})

  #   {:noreply, socket}
  # end

  # def handle_event("submit-button-click",_params,
  #     %{
  #         assigns: %{
  #           submit_button_action: submit_button_action,
  #           submit_button_param: submit_button_param
  #         }
  #       } = socket
  #     ) do
  #   send(self(),{__MODULE__,:button_clicked,%{action: submit_button_action, param: submit_button_param}})

  #   {:noreply, socket}
  # end


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
