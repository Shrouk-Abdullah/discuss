defmodule DiscussWeb.Models.User do
  alias DiscussWeb.Models.Topic
  use DiscussWeb, :model

  schema "users" do
    # what columns in database
    field :email, :string
    field :provider, :string
    field :token, :string
    #  user can add many topic
    has_many :topics, Topic
    timestamps()
  end

  # discripe how we want to change a record
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:email, :provider, :token])
    |> validate_required([:email, :provider, :token])
  end
end
