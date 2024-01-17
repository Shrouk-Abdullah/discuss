defmodule DiscussWeb.TopicController do
  use DiscussWeb, :controller
  alias Discuss.Repo
  alias DiscussWeb.Models.Topic
  import DiscussWeb.Router.Helpers

  def index(conn, _params) do
    # Discuss.Repo.all(DiscussWeb.Models.Topic)
    topics = Repo.all(Topic)
    render(conn, :index, topics: topics)
  end

  def new(conn, _params) do
    changeset = Topic.changeset(%Topic{}, %{})

    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"topic" => topic}) do
    # %{"topic" => topic} = params
    # for creatin from scratch we sent Topic{} empty
    changeset = Topic.changeset(%Topic{}, topic)
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
end
