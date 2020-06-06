defmodule Cookpod.Recipes.Ingredient do
  use Ecto.Schema
  import Ecto.Changeset

  alias Cookpod.Recipes.Product
  alias Cookpod.Recipes.Recipe

  schema "ingredients" do
    field :amount, :integer
    belongs_to :recipe, Recipe
    belongs_to :product, Product

    timestamps()
  end

  @doc false
  def changeset(ingredient, attrs) do
    ingredient
    |> cast(attrs, [:amount])
    |> validate_required([:amount])
  end
end
