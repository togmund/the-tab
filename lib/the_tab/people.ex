defmodule TheTab.People do
  @moduledoc """
  The People context.
  """

  import Ecto.Query, warn: false
  alias TheTab.Repo

  alias TheTab.People.Group
  alias TheTab.People.Member
  alias TheTab.People.User

  alias TheTab.Transactions.Entry
  alias TheTab.Transactions.Receipt

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a User.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  @doc """
  Returns the list of groups.

  ## Examples

      iex> list_groups()
      [%Group{}, ...]

  """
  def list_groups do
    Repo.all(Group)
  end

  @doc """
  Gets a single group.

  Raises `Ecto.NoResultsError` if the Group does not exist.

  ## Examples

      iex> get_group!(123)
      %Group{}

      iex> get_group!(456)
      ** (Ecto.NoResultsError)

  """
  def get_group!(id), do: Repo.get!(Group, id)

  @doc """
  Creates a group.

  ## Examples

      iex> create_group(%{field: value})
      {:ok, %Group{}}

      iex> create_group(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_group(attrs \\ %{}) do
    %Group{}
    |> Group.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a group.

  ## Examples

      iex> update_group(group, %{field: new_value})
      {:ok, %Group{}}

      iex> update_group(group, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_group(%Group{} = group, attrs) do
    group
    |> Group.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Group.

  ## Examples

      iex> delete_group(group)
      {:ok, %Group{}}

      iex> delete_group(group)
      {:error, %Ecto.Changeset{}}

  """
  def delete_group(%Group{} = group) do
    Repo.delete(group)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking group changes.

  ## Examples

      iex> change_group(group)
      %Ecto.Changeset{source: %Group{}}

  """
  def change_group(%Group{} = group) do
    Group.changeset(group, %{})
  end

  @doc """
  Returns the list of members.

  ## Examples

      iex> list_members()
      [%Member{}, ...]

  """
  def list_members do
    Repo.all(Member)
  end

  @doc """
  Gets a single member.

  Raises `Ecto.NoResultsError` if the Member does not exist.

  ## Examples

      iex> get_member!(123)
      %Member{}

      iex> get_member!(456)
      ** (Ecto.NoResultsError)

  """
  def get_member!(id), do: Repo.get!(Member, id)

  @doc """
  Creates a member.

  ## Examples

      iex> create_member(%{field: value})
      {:ok, %Member{}}

      iex> create_member(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_member(attrs \\ %{}) do
    %Member{}
    |> Member.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a member.

  ## Examples

      iex> update_member(member, %{field: new_value})
      {:ok, %Member{}}

      iex> update_member(member, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_member(%Member{} = member, attrs) do
    member
    |> Member.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Member.

  ## Examples

      iex> delete_member(member)
      {:ok, %Member{}}

      iex> delete_member(member)
      {:error, %Ecto.Changeset{}}

  """
  def delete_member(%Member{} = member) do
    Repo.delete(member)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking member changes.

  ## Examples

      iex> change_member(member)
      %Ecto.Changeset{source: %Member{}}

  """
  def change_member(%Member{} = member) do
    Member.changeset(member, %{})
  end

  @doc """
  Returns the list of members in one group by the group_id.

  Raises `Ecto.NoResultsError` if the Group does not exist.

  ## Examples

      iex> list_member_ids!(123)
      [4, 6, 13, ...]

      iex> list_member_ids!(456)
      ** (Ecto.NoResultsError)

  """
  def list_member_ids!(group_id) do
    from(m in Member,
      where: m.group_id == ^group_id,
      select: m.id
    )
    |> Repo.all()
  end

  @doc """
  Returns the list of members in one group and their associated debts

  Raises `Ecto.NoResultsError` if the Group does not exist.

  ## Examples

      iex> TheTab.People.list_members_and_debts!(1)
      [{:ok, %Member{}, 40_000}, ...]

      iex> TheTab.People.list_members_and_debts!(30)
      ** (Ecto.NoResultsError)

  """
  def list_members_and_debts!(group_id) do
    debt_query =
      from(m in Member,
        join: e in Entry,
        on: m.id == e.member_id,
        join: r in Receipt,
        on: e.receipt_id == r.id,
        join: u in User,
        on: m.user_id == u.id,
        where: m.group_id == ^group_id,
        select: %{
          member_id: m.id,
          member_name: u.name,
          owes:
            fragment(
              "ROUND(?)",
              r.total / count(r.id)
            )
        },
        group_by: [m.id, u.name, r.total, r.id]
      )

    credit_query =
      from(m in Member,
        join: e in Entry,
        on: m.id == e.member_id,
        join: r in Receipt,
        on: e.receipt_id == r.id,
        join: u in User,
        on: m.user_id == u.id,
        where: m.group_id == ^group_id and not is_nil(e.amount_paid),
        select: %{
          member_id: m.id,
          member_name: u.name,
          owed: e.amount_paid
        }
      )

    from(d in subquery(debt_query),
      join: c in subquery(credit_query),
      on: c.member_id == d.member_id,
      select: {d.member_name, sum(d.owes) - sum(c.owed)},
      group_by: d.member_name
    )
    |> Repo.all()
  end
end
