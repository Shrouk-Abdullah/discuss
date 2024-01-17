defmodule Discuss.Repo.Migrations.AddUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :provider, :string
      add :token, :string

      # the timestamps function is used to automatically add two columns, inserted_at
      # and updated_at, to a database table. These columns are often used to track when a
      # record was first inserted into the database (inserted_at) and when it was last
      # updated (updated_at).
      timestamps()
    end
  end
end
