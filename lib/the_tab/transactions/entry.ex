defmodule TheTab.Transactions.Entry do
  use Ecto.Schema
  import Ecto.Changeset

  schema "entries" do
    field :amount_paid, :integer
    field :share, :boolean, default: false
    field :receipt_id, :id
    field :member_id, :id

    timestamps()
  end

  @doc false
  def changeset(entry, attrs) do
    entry
    |> cast(attrs, [:amount_paid, :share])
    |> validate_required([:amount_paid, :share])
  end
end
