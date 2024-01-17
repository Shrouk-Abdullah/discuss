defmodule DiscussWeb.Models.Topic do
  alias DiscussWeb.Models.User
  use DiscussWeb, :model

  schema "topics" do
    # single column in postgress called title
    field :title, :string
    # topic only has one created user
    belongs_to :user, User
  end

  def changeset(struct, params \\ %{}) do
    # struct represents record in datatbase
    # params contain new updates to model (struct)
    # cast produces changeset(object records updates in our database  , descripe how we want to update databse)
    struct
    |> cast(params, [:title])
    |> validate_required([:title])
  end
end
