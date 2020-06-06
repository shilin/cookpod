defmodule Cookpod.Recipes.Recipe do
  use Ecto.Schema
  use Arc.Ecto.Schema

  import Ecto.Changeset

  alias Cookpod.Recipes.Uploaders.Picture
  alias Cookpod.Recipes.Ingredient

  schema "recipes" do
    field :description, :string
    field :name, :string
    field :picture, Picture.Type

    has_many :ingredients, Ingredient
    has_many :products, through: [:ingredients, :product]

    embeds_one :meta, Meta do
      field :vegan, :string, default: "none"
    end

    timestamps()
  end

  @doc false
  def changeset(recipe, attrs) do
    recipe
    |> cast(attrs, [:name, :description])
    |> cast_attachments(attrs, [:picture])
    |> validate_required([:name, :description])
    |> unique_constraint(:name)
  end
end
