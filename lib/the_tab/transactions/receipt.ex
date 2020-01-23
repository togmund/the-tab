defmodule TheTab.Transactions.Receipt do
  use Ecto.Schema
  import Ecto.Changeset

  schema "receipts" do
    field :tag, :string
    field :total, :integer

    timestamps()
  end

  @doc false
  def changeset(receipt, attrs) do
    receipt
    |> cast(attrs, [:tag, :total])
    |> validate_required([:tag, :total])
  end
end
