defmodule TheTab.Repo.Migrations.CreateEntries do
  use Ecto.Migration

  def change do
    create table(:entries) do
      add :amount_paid, :integer
      add :share, :boolean, default: false, null: false
      add :receipt_id, references(:receipts, on_delete: :nothing)
      add :member_id, references(:members, on_delete: :nothing)

      timestamps()
    end

    create index(:entries, [:receipt_id])
    create index(:entries, [:member_id])
  end
end
