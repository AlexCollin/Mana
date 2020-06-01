defmodule Admin.LayoutView do
  use Admin, :view

  def easy_breadcrumbs(conn) do
    if conn do
      Admin.Router.Helpers.url(conn) <> conn.request_path
      |> Admin.Breadcrumbs.breadcrumbs
      |> raw
    end
  end
end
