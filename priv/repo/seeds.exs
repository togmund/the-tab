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
group_names = ["Golden Geese", "McTavish"]

# People for Seeds
person_names = ["Noah", "Ted", "Mike", "Gregg", "Mallory", "Kailey", "Tanyss", "Jon", "Tristan"]

# Possible Tags
tags = ["Food", "Event", "Game"]

group_names
|> Enum.each(fn name ->
  Repo.insert!(%Group{
    name: name
  })
end)

person_names
|> Enum.each(fn name ->
  Repo.insert!(%User{
    name: name
  })
end)

1..length(person_names)
|> Enum.each(fn index ->
  Repo.insert!(%Member{
    user_id: index,
    group_id: Enum.random(1..length(group_names))
  })
end)

Repo.insert!(%Receipt{
  tag: "food",
  total: 1
})

Repo.insert!(%Entry{
  receipt_id: 1,
  member_id: 1,
  amount_paid: 1,
  share: true
})
