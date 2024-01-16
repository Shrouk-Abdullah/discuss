defmodule DiscussWeb.TopicController do
  use DiscussWeb, :controller
  alias Discuss.Repo
  alias DiscussWeb.Models.Topic

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
        |> redirect(to: DiscussWeb.Router.Helpers.topic_path(conn, :showTopics))

      #  IO.inspect(post)

      {:error, changeset} ->
        render(conn, :new, changeset: changeset)
        IO.inspect(changeset, label: "Changeset Errors")
    end
  end

  def showTopics(conn, _params) do
    # Discuss.Repo.all(DiscussWeb.Models.Topic)
    topics = Repo.all(Topic)
    render(conn, :show, topics: topics)
  end
end
