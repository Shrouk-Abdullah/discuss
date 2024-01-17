defmodule DiscussWeb.AuthController do
  alias Discuss.Repo
  alias DiscussWeb.Models.User
  use DiscussWeb, :controller
  # it updates conn object
  plug Ueberauth
  import DiscussWeb.Router.Helpers

  # callback for uberauth
  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, params) do
    # IO.inspect(auth)

    user_params = %{
      token: auth.credentials.token,
      email: auth.info.email,
      # it returns :github so we want to make it string
      provider: Atom.to_string(auth.provider)
    }

    changeset = User.changeset(%User{}, user_params)
    IO.inspect(changeset)
    # insert_or_update_user(changeset)
    signin(conn, changeset)
  end

  defp signin(conn, changeset) do
    case insert_or_update_user(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Welcom back")
        |> put_session(:user_id, user.id)
        |> redirect(to: topic_path(conn, :index))

      {:error, _reson} ->
        conn
        |> put_flash(:error, "Error signning in")
        |> redirect(to: topic_path(conn, :index))
    end
  end

  defp insert_or_update_user(changeset) do
    email = get_field(changeset, :email)
    IO.inspect(Repo.get_by(User, email: changeset.changes.email))

    case Repo.get_by(User, email: changeset.changes.email) do
      nil -> Repo.insert(changeset)
      # we have that user in databse
      user -> {:ok, user}
    end
  end

  defp get_field(changeset, field) do
    # Extract the field from the changeset's changes or data map
    Map.get(changeset.changes, field, Map.get(changeset.data, field))
  end

  # def callback(conn, %{"provider" => "github", "code" => code} = params) do
  #   # Your implementation here
  # conn
  # |> send_resp(302, "")
  #   IO.inspect(params, label: "Received Parameters")
  #   IO.inspect(conn.asigns)
  # end
end
