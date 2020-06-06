defmodule Cookpod.Repo.Migrations.CreateIngredients do
  use Ecto.Migration

  def change do
    create table(:ingredients) do
      add :amount, :integer
      add :recipe_id, references(:recipes, on_delete: :nothing)
      add :product_id, references(:products, on_delete: :nothing)

      timestamps()
    end

    create index(:ingredients, [:recipe_id, :product_id], uniq: true)
  end
end
