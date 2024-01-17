defmodule Discuss.Repo.Migrations.AddUserIdToTopics do
  use Ecto.Migration

  def change do
    alter table(:topics) do
      # spicify refrece to anther table in database
      add :user_id, references(:users)
    end
  end
end
