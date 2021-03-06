defmodule Admin.Router do
  use Admin, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :put_root_layout, {Admin.LayoutView, :root}
    # plug Admin.CurrentUserPlug
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Admin do
    pipe_through :browser

    live "/", MainLive.Index, :index

    # get "/login", SessionController, :new

    scope "/telegram" do
      live "/accounts", AccountLive.Index, :index
      scope "/accounts", AccountLive do
        live "/new", Index, :new
        live "/:id/edit", Index, :edit

        live "/:id", Show, :show
        live "/:id/show/edit", Show, :edit
      end
    end

    # resources "/sessions", SessionController, only: [:create, :delete]

  end

  # Other scopes may use custom stacks.
  # scope "/api", Admin do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: Admin.Telemetry
    end
  end
end
