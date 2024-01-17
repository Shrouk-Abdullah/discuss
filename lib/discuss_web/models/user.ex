defmodule DiscussWeb.Models.User do
  use DiscussWeb, :model

  schema "users" do
    # what columns in database
    field :email, :string
    field :provider, :string
    field :token, :string
    timestamps()
  end

  # discripe how we want to change a record
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:email, :provider, :token])
    |> validate_required([:email, :provider, :token])
  end
end
