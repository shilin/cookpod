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
  Repo.insert!(User.changeset(%User{}, user), on_conflict: :nothing)
end)

leek =
  Repo.insert!(%Cookpod.Recipes.Product{name: "leek", fats: 0, carbs: 14, proteins: 1},
    on_conflict: :nothing
  )

garlic =
  Repo.insert!(%Cookpod.Recipes.Product{name: "garlic", fats: 0, carbs: 33, proteins: 6},
    on_conflict: :nothing
  )

broccoli =
  Repo.insert!(%Cookpod.Recipes.Product{name: "broccoli", fats: 0, carbs: 7, proteins: 3},
    on_conflict: :nothing
  )

butter =
  Repo.insert!(%Cookpod.Recipes.Product{name: "butter", fats: 81, carbs: 0, proteins: 1},
    on_conflict: :nothing
  )

thyme =
  Repo.insert!(%Cookpod.Recipes.Product{name: "thyme", fats: 2, carbs: 24, proteins: 6},
    on_conflict: :nothing
  )

flour =
  Repo.insert!(%Cookpod.Recipes.Product{name: "flour", fats: 2, carbs: 75, proteins: 11},
    on_conflict: :nothing
  )

milk =
  Repo.insert!(%Cookpod.Recipes.Product{name: "milk", fats: 7, carbs: 5, proteins: 6},
    on_conflict: :nothing
  )

macaroni =
  Repo.insert!(%Cookpod.Recipes.Product{name: "dried macaroni", fats: 1, carbs: 75, proteins: 13},
    on_conflict: :nothing
  )

parmesan =
  Repo.insert!(
    %Cookpod.Recipes.Product{name: "Parmesan cheese", fats: 25, carbs: 333, proteins: 36},
    on_conflict: :nothing
  )

cheddar =
  Repo.insert!(
    %Cookpod.Recipes.Product{name: "Cheddar cheese", fats: 33, carbs: 33, proteins: 23},
    on_conflict: :nothing
  )

spinach =
  Repo.insert!(%Cookpod.Recipes.Product{name: "spinach", fats: 0, carbs: 4, proteins: 3},
    on_conflict: :nothing
  )

almonds =
  Repo.insert!(%Cookpod.Recipes.Product{name: "almonds", fats: 50, carbs: 22, proteins: 21},
    on_conflict: :nothing
  )

recipe =
  Repo.insert!(%Cookpod.Recipes.Recipe{
    name: "Greens mac 'n' cheese",
    description: """
    A Friday-night favourite, this is a twist on a comfort classic that uses
    broccoli in two ways – the blitzed-up stalks add colour and punch to the
    sauce, while you enjoy the delicate florets with your pasta. Join the green team!
    """

    # ,
    # picture:
    #   "https://img1.jamieoliver.com/jamieoliver/recipe-database/xtra_med/92507790.jpg?tr=w-400"
  })

Repo.insert!(%Cookpod.Recipes.Ingredient{recipe: recipe, amount: 10, product: leek},
  on_conflict: :nothing
)

Repo.insert!(%Cookpod.Recipes.Ingredient{recipe: recipe, amount: 30, product: garlic},
  on_conflict: :nothing
)

Repo.insert!(%Cookpod.Recipes.Ingredient{recipe: recipe, amount: 400, product: broccoli},
  on_conflict: :nothing
)

Repo.insert!(%Cookpod.Recipes.Ingredient{recipe: recipe, amount: 40, product: butter},
  on_conflict: :nothing
)

Repo.insert!(%Cookpod.Recipes.Ingredient{recipe: recipe, amount: 15, product: thyme},
  on_conflict: :nothing
)

Repo.insert!(%Cookpod.Recipes.Ingredient{recipe: recipe, amount: 20, product: flour},
  on_conflict: :nothing
)

Repo.insert!(%Cookpod.Recipes.Ingredient{recipe: recipe, amount: 90, product: milk},
  on_conflict: :nothing
)

Repo.insert!(%Cookpod.Recipes.Ingredient{recipe: recipe, amount: 450, product: macaroni},
  on_conflict: :nothing
)

Repo.insert!(%Cookpod.Recipes.Ingredient{recipe: recipe, amount: 30, product: parmesan},
  on_conflict: :nothing
)

Repo.insert!(%Cookpod.Recipes.Ingredient{recipe: recipe, amount: 150, product: cheddar},
  on_conflict: :nothing
)

Repo.insert!(%Cookpod.Recipes.Ingredient{recipe: recipe, amount: 100, product: spinach},
  on_conflict: :nothing
)

Repo.insert!(%Cookpod.Recipes.Ingredient{recipe: recipe, amount: 50, product: almonds},
  on_conflict: :nothing
)
