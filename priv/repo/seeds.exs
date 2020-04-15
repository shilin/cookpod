# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Cookpod.Repo.insert!(%Cookpod.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Cookpod.Repo
alias Cookpod.User

users = [
  %{email: "user@test.com", password: "1111", password_confirmation: "1111"},
  %{email: "admin@test.com", password: "1234", password_confirmation: "1234"}
]

Enum.each(users, fn user ->
  Repo.insert!(User.changeset(%User{}, user))
end)
