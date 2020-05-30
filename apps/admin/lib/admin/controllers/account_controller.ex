defmodule Admin.AccountController do
  use Admin, :controller

  import Ecto

  plug :assign_user
  plug :scrub_params, "account" when action in [:create, :update]
  plug :authorize_user
  plug :set_authorization_flag

  alias Core.{Accounts, Accounts.Account}
  alias Core.Users
  alias Core.Repo

  def create(conn, %{"account" => account_params}) do
    changeset = Account.changeset(%Account{}, account_params)

    case Repo.insert(changeset) do
      {:ok, account} ->
        json conn |> put_status(:created), account
      {:error, _changeset} ->
        json conn |> put_status(:bad_request), %{errors: ["unable to create account"] }
    end
  end

  defp is_authorized_user?(conn) do
    user = get_session(conn, :current_user)
    (user && (Integer.to_string(user.id) == conn.params["user_id"] || Core.RoleChecker.is_admin?(user)))
  end

  defp authorize_user(conn, _opts) do
    if is_authorized_user?(conn) do
      conn
    else
      conn
      |> put_flash(:error, "You are not authorized to modify that post!")
      |> redirect(to: Routes.session_path(conn, :new))
      |> halt
    end
  end

  defp assign_user(conn, _opts) do
    user = get_session(conn, :current_user)
        case Users.get_user!(user.id) do
          nil  -> invalid_user(conn)
          user -> assign(conn, :user, user)
        end
  end

  defp invalid_user(conn) do
    conn
    |> put_flash(:error, "Invalid user!")
    |> redirect(to: Routes.session_path(conn, :new))
    |> halt
  end

  defp set_authorization_flag(conn, _opts) do
    assign(conn, :author_or_admin, is_authorized_user?(conn))
  end

end
