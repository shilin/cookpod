defmodule CookpodWeb.RecipeView do
  use CookpodWeb, :view
  alias Cookpod.Recipes.Uploaders.Picture
  alias CookpodWeb.Endpoint

  def picture_url(recipe) do
    do_picture_url(recipe.picture, recipe)
  end

  defp do_picture_url(nil, _), do: nil

  defp do_picture_url(picture, recipe) do
    Endpoint.url() <> Picture.url({picture, recipe})
  end

  def recipe_calories(recipe) do
    recipe.ingredients
    |> Enum.map(fn i -> 0.01 * i.amount * product_calories(i.product) end)
    |> Enum.sum()
    |> round
  end

  defp product_calories(product) do
    9 * product.fats + 4 * product.carbs + 4 * product.proteins
  end
end
