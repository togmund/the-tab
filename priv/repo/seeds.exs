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

Repo.insert!(%Group{
  name: "Something"
})

Repo.insert!(%User{
  name: "Something"
})

Repo.insert!(%Member{
  group_id: 1,
  user_id: 1
})

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
