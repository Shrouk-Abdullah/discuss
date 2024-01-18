defmodule DiscussWeb.Models.Comment do
  alias DiscussWeb.Models.Topic
  alias DiscussWeb.Models.User
  use DiscussWeb, :model

  schema "comments" do
    field :content, :string
    # has only one user
    belongs_to :user, User
    # has only one topic
    belongs_to :topic, Topic
    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:content])
    |> validate_required([:content])
  end
end
