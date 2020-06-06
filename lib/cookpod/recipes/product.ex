defmodule Cookpod.Recipes.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :carbs, :integer
    field :fats, :integer
    field :name, :string
    field :proteins, :integer

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :fats, :carbs, :proteins])
    |> validate_required([:name, :fats, :carbs, :proteins])
    |> unique_constraint(:name)
  end
end
