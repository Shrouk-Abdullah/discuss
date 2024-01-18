defmodule DiscussWeb.TopicController do
  use DiscussWeb, :controller
  alias Discuss.Repo
  alias DiscussWeb.Models.Topic
  import DiscussWeb.Router.Helpers
  import Ecto

  plug DiscussWeb.Plugs.RequireAuth when action in [:new, :create, :edit, :update, :delete]
  plug :check_topic_owner when action in [:edit, :update, :delete]

  def index(conn, _params) do
    # Discuss.Repo.all(DiscussWeb.Models.Topic)
    IO.inspect(conn.assigns)
    topics = Repo.all(Topic)
    render(conn, :index, topics: topics)
  end

  def show(conn, %{"id" => topic_id}) do
    topic = Repo.get!(Topic, topic_id)
    render(conn, :show, topic: topic)
  end

  def new(conn, _params) do
    changeset = Topic.changeset(%Topic{}, %{})

    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"topic" => topic}) do
    # %{"topic" => topic} = params
    # for creatin from scratch we sent Topic{} empty
    # conn,assign[:user]
    # changeset = Topic.changeset(%Topic{}, topic)

    changeset =
      conn.assigns.user
      |> build_assoc(:topics)
      |> Topic.changeset(topic)

    # Repo responsiple for insrting data in postgress
    case(Repo.insert(changeset)) do
      {:ok, _post} ->
        conn
        |> put_flash(:info, "Topic Created")
        # /////////////////////// DiscussWeb.Router.Helpers.topic_path for topic_path error ////////////////////
        |> redirect(to: topic_path(conn, :index))

      #  IO.inspect(post)

      {:error, changeset} ->
        render(conn, :new, changeset: changeset)
        IO.inspect(changeset, label: "Changeset Errors")
    end
  end

  # to get user_with_topics = Discuss.Repo.get(DiscussWeb.Models.User, 1) |> Discuss.Repo.preload(:topics)
  # get "/topic/:id/edit", TopicController, :edit => id for id in route

  def edit(conn, %{"id" => topic_id}) do
    # actual record in database
    topic = Repo.get(Topic, topic_id)
    changeset = Topic.changeset(topic)
    render(conn, :edit, changeset: changeset, topic: topic)
  end

  def update(conn, %{"id" => topic_id, "topic" => topic}) do
    old_topic = Repo.get(Topic, topic_id)
    changeset = Topic.changeset(old_topic, topic)
    # changeset =
    #   Repo.get(Topic, topic_id)
    #   |> Topic.changeset(topic)

    case Repo.update(changeset) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic updated")
        |> redirect(to: topic_path(conn, :index))

      {:error, changeset} ->
        render(conn, :edit, changeset: changeset, old_topic: old_topic)
    end
  end

  def delete(conn, %{"id" => topic_id}) do
    # Repo.delete!()=> (!) it's raise an error whan happened
    # fetch record from datbse then delete it
    Repo.get!(Topic, topic_id)
    |> Repo.delete!()

    conn
    |> put_flash(:info, "Topic Deleted")
    |> redirect(to: topic_path(conn, :index))
  end

  def check_topic_owner(conn, _params) do
    %{params: %{"id" => topic_id}} = conn
    # fetch topic in database that user try to access
    if(Repo.get(Topic, topic_id).user_id == conn.assigns.user.id) do
      conn
    else
      conn
      |> put_flash(:error, "You can't edit that")
      |> redirect(to: topic_path(conn, :index))
      |> halt()
    end
  end
end
