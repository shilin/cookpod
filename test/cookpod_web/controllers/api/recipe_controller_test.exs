defmodule CookpodWeb.Api.RecipeControllerTest do
  use CookpodWeb.ConnCase
  use PhoenixSwagger.SchemaTest, "priv/static/swagger.json"

  alias Cookpod.Recipes

  setup [:create_recipe]

  test "GET /api/v2/recipes", %{conn: conn, swagger_schema: schema} do
    conn
    |> get(Routes.api_recipe_path(conn, :index))
    |> validate_resp_schema(schema, "RecipesResponse")
    |> json_response(200)
  end

  test "GET /api/v2/recipes/:id", %{conn: conn, recipe: recipe, swagger_schema: schema} do
    conn
    |> get(Routes.api_recipe_path(conn, :show, recipe))
    |> validate_resp_schema(schema, "RecipeResponse")
    |> json_response(200)
  end

  defp create_recipe(_) do
    {:ok, recipe} =
      Recipes.create_recipe(%{name: "Name Recipe", description: "Description Recipe"})

    {:ok, %{recipe: recipe}}
  end
end
