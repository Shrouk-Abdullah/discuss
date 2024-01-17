# init just onetime and call function
defmodule DiscussWeb.Plugs.SetUser do
  # for assign
  import Plug.Conn
  # for get_session
  import Phoenix.Controller
  alias DiscussWeb.Models.User
  alias Discuss.Repo

  #
  def init(_params) do
  end

  def call(conn, _params) do
    user_id = get_session(conn, :user_id)

    cond do
      user = user_id && Repo.get(User, user_id) ->
        # modify a connection update :user property to user
        assign(conn, :user, user)

      true ->
        assign(conn, :user, nil)
    end
  end 
end
