# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     TheTab.Repo.insert!(%TheTab.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
import Ecto.Query, warn: false
alias TheTab.Repo

alias TheTab.People.Group
alias TheTab.People.Member
alias TheTab.People.User

alias TheTab.Transactions.Entry
alias TheTab.Transactions.Receipt

# Groups for Seeds
group_names = ["Golden Geese", "McTavish", "Bradford", "Woodwards", "Stronglot"]

# People for Seeds
user_names = [
  "David",
  "John",
  "Paul",
  "Mark",
  "James",
  "Andrew",
  "Scott",
  "Steven",
  "Robert",
  "Stephen",
  "William",
  "Craig",
  "Michael",
  "Stuart",
  "Christopher",
  "Alan",
  "Colin",
  "Brian",
  "Kevin",
  "Gary",
  "Richard",
  "Derek",
  "Martin",
  "Zoe",
  "Lindsay",
  "Stephanie",
  "Judith",
  "Mandy",
  "Jillian",
  "Mhairi",
  "Barbara",
  "Carolyn",
  "Gayle",
  "Maria",
  "Valerie",
  "Christina"
]

# Possible Tags
tags = ["Food", "Event", "Game"]

# Create a group for each group_name
group_names
|> Enum.each(fn name ->
  Repo.insert!(%Group{
    name: name
  })
end)

# Create a user for each user_name
user_names
|> Enum.each(fn name ->
  Repo.insert!(%User{
    name: name
  })
end)

# Add each user to exactly one group
1..length(user_names)
|> Enum.each(fn index ->
  Repo.insert!(%Member{
    user_id: index,
    group_id: Enum.random(1..length(group_names))
  })
end)

# Create a bunch of random receipts valued between $8 and $25
1..30
|> Enum.each(fn _index ->
  Repo.insert!(%Receipt{
    tag: Enum.random(tags),
    total: Enum.random(800..2500)
  })
end)

# Create a set of entries for each receipt
TheTab.Transactions.list_receipts()
|> Enum.each(fn receipt ->
  # Picks a group at random
  group =
    1..length(group_names)
    |> Enum.random()

  # Gets the full member list
  members =
    group
    |> TheTab.People.list_member_ids!()

  # Picks one at random to be the payer
  payer =
    members
    |> Enum.random()

  # Creates the entry with the Payer
  %Entry{
    receipt_id: receipt.id,
    member_id: payer,
    amount_paid: receipt.total,
    share: true
  }
  |> Repo.insert!()

  # Generates a list of members that doesn't include the payer
  sharers =
    members
    |> Enum.filter(fn member -> member != payer end)
    |> Enum.shuffle()
    |> Enum.slice(
      0,
      1..(length(members) - 1)
      |> Enum.random()
    )
    # Creates the entries for some random number of sharers, at least one
    |> Enum.each(fn sharer ->
      %Entry{
        receipt_id: receipt.id,
        member_id: sharer,
        amount_paid: nil,
        share: true
      }
      |> Repo.insert!()
    end)
end)
