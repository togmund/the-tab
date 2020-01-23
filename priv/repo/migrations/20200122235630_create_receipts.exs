defmodule TheTab.Repo.Migrations.CreateReceipts do
  use Ecto.Migration

  def change do
    create table(:receipts) do
      add :tag, :string
      add :total, :integer

      timestamps()
    end

  end
end
