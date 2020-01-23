defmodule TheTab.Repo.Migrations.CreateMembers do
  use Ecto.Migration

  def change do
    create table(:members) do
      add :group_id, references(:groups, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:members, [:group_id])
    create index(:members, [:user_id])
  end
end
