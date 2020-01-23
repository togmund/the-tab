defmodule TheTab.TransactionsTest do
  use TheTab.DataCase

  alias TheTab.Transactions

  describe "receipts" do
    alias TheTab.Transactions.Receipt

    @valid_attrs %{tag: "some tag", total: 42}
    @update_attrs %{tag: "some updated tag", total: 43}
    @invalid_attrs %{tag: nil, total: nil}

    def receipt_fixture(attrs \\ %{}) do
      {:ok, receipt} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Transactions.create_receipt()

      receipt
    end

    test "list_receipts/0 returns all receipts" do
      receipt = receipt_fixture()
      assert Transactions.list_receipts() == [receipt]
    end

    test "get_receipt!/1 returns the receipt with given id" do
      receipt = receipt_fixture()
      assert Transactions.get_receipt!(receipt.id) == receipt
    end

    test "create_receipt/1 with valid data creates a receipt" do
      assert {:ok, %Receipt{} = receipt} = Transactions.create_receipt(@valid_attrs)
      assert receipt.tag == "some tag"
      assert receipt.total == 42
    end

    test "create_receipt/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Transactions.create_receipt(@invalid_attrs)
    end

    test "update_receipt/2 with valid data updates the receipt" do
      receipt = receipt_fixture()
      assert {:ok, %Receipt{} = receipt} = Transactions.update_receipt(receipt, @update_attrs)
      assert receipt.tag == "some updated tag"
      assert receipt.total == 43
    end

    test "update_receipt/2 with invalid data returns error changeset" do
      receipt = receipt_fixture()
      assert {:error, %Ecto.Changeset{}} = Transactions.update_receipt(receipt, @invalid_attrs)
      assert receipt == Transactions.get_receipt!(receipt.id)
    end

    test "delete_receipt/1 deletes the receipt" do
      receipt = receipt_fixture()
      assert {:ok, %Receipt{}} = Transactions.delete_receipt(receipt)
      assert_raise Ecto.NoResultsError, fn -> Transactions.get_receipt!(receipt.id) end
    end

    test "change_receipt/1 returns a receipt changeset" do
      receipt = receipt_fixture()
      assert %Ecto.Changeset{} = Transactions.change_receipt(receipt)
    end
  end

  describe "entries" do
    alias TheTab.Transactions.Entry

    @valid_attrs %{amount_paid: 42, share: true}
    @update_attrs %{amount_paid: 43, share: false}
    @invalid_attrs %{amount_paid: nil, share: nil}

    def entry_fixture(attrs \\ %{}) do
      {:ok, entry} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Transactions.create_entry()

      entry
    end

    test "list_entries/0 returns all entries" do
      entry = entry_fixture()
      assert Transactions.list_entries() == [entry]
    end

    test "get_entry!/1 returns the entry with given id" do
      entry = entry_fixture()
      assert Transactions.get_entry!(entry.id) == entry
    end

    test "create_entry/1 with valid data creates a entry" do
      assert {:ok, %Entry{} = entry} = Transactions.create_entry(@valid_attrs)
      assert entry.amount_paid == 42
      assert entry.share == true
    end

    test "create_entry/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Transactions.create_entry(@invalid_attrs)
    end

    test "update_entry/2 with valid data updates the entry" do
      entry = entry_fixture()
      assert {:ok, %Entry{} = entry} = Transactions.update_entry(entry, @update_attrs)
      assert entry.amount_paid == 43
      assert entry.share == false
    end

    test "update_entry/2 with invalid data returns error changeset" do
      entry = entry_fixture()
      assert {:error, %Ecto.Changeset{}} = Transactions.update_entry(entry, @invalid_attrs)
      assert entry == Transactions.get_entry!(entry.id)
    end

    test "delete_entry/1 deletes the entry" do
      entry = entry_fixture()
      assert {:ok, %Entry{}} = Transactions.delete_entry(entry)
      assert_raise Ecto.NoResultsError, fn -> Transactions.get_entry!(entry.id) end
    end

    test "change_entry/1 returns a entry changeset" do
      entry = entry_fixture()
      assert %Ecto.Changeset{} = Transactions.change_entry(entry)
    end
  end
end
