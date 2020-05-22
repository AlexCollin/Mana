defmodule Core.RoleChecker do
  alias Core.Repo
  alias Core.Role

  def is_admin?(user) do
    (role = Repo.get(Role, user.role_id)) && role.admin
  end
end
