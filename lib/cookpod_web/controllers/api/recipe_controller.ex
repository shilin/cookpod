defmodule CookpodWeb.Api.RecipeController do
  use CookpodWeb, :controller
  use PhoenixSwagger

  alias Cookpod.Recipes

  def swagger_definitions do
    %{
      Recipe:
        swagger_schema do
          title("Recipe")
          description("Steps, describing how to cook")

          properties do
            id(:integer, "Recipe ID", required: true)
            name(:string, "Recipe name", required: true)
            description(:string, "Recipe description", required: true)
            picture([:string, "null"], "Recipe picture url")
            inserted_at(:string, "Creation timestamp", format: :datetime)
            updated_at(:string, "Update timestamp", format: :datetime)
          end

          example(%{
            id: 10,
            name: "Baked Apple",
            description: "Put a whole apple into oven and bake it!"
          })
        end,
      RecipeRequest:
        swagger_schema do
          title("RecipeRequest")
          description("POST body for creating a request")
          property(:recipe, Schema.ref(:Recipe), "The recipe details")
        end,
      RecipeResponse:
        swagger_schema do
          title("RecipeResponse")
          description("Response schema for single recipe")
          property(:data, Schema.ref(:Recipe), "The recipe details")
        end,
      RecipesResponse:
        swagger_schema do
          title("RecipesResponse")
          description("Response schema for multiple recipe")
          property(:data, Schema.array(:Recipe), "The recipe details")
        end
    }
  end

  swagger_path(:index) do
    get("/recipes")
    summary("List Recipes")
    description("List all recipes in the database")
    produces("application/json")

    response(200, "SUCCESS", Schema.array(:Recipe),
      example: %{
        data: [
          %{
            id: 10,
            name: "Baked Apple",
            description: "Put a whole apple into oven and bake it!",
            picture: "/uploads/apple.jpg"
          },
          %{
            id: 20,
            name: "Scrambled Eggs",
            description: "Put eggs into bowl, scramble, put on stove, fry!",
            picture: "/uploads/eggs.jpg"
          }
        ]
      }
    )
  end

  def index(conn, _params) do
    render(conn, "index.json", recipes: Recipes.list_recipes())
  end

  swagger_path(:show) do
    get("/recipes/{id}")
    summary("Show Recipe")
    description("Show one recipe found by ID in the database")
    parameter(:id, :path, :integer, "ID", required: true, example: 123)
    produces("application/json")
    response(200, "SUCCESS", Schema.ref(:Recipe),
      example: %{
        data: %{
        id: 10,
        name: "Baked Apple",
        description: "Put a whole apple into oven and bake it!",
            picture: "/uploads/apple.jpg"
        }
      }
    )
  end

  def show(conn, %{"id" => id}) do
    render(conn, "show.json", recipe: Recipes.get_recipe!(id))
  end
end
