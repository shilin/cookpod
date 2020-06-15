defmodule Cookpod.Recipes.Loot do
  use Broadway

  # import Ecto.Changeset
  alias Cookpod.Recipes.Recipe
  alias Cookpod.Repo

  def start_link(_opts \\ []) do
    Broadway.start_link(__MODULE__,
      name: __MODULE__,
      producer: [
        module:
          {BroadwayKafka.Producer,
           [
             hosts: [localhost: 9092],
             group_id: "group_1",
             topics: ["recipes"]
           ]},
        concurrency: 10
      ],
      processors: [
        default: [
          concurrency: 10
        ]
      ]
    )
  end

  def handle_message(_, message, _) do
    %{"name" => name, "description" => description} = Jason.decode!(message.data)
    # IO.inspect(Jason.decode!(message.data), label: "Got message")
    %Recipe{}
    |> Recipe.changeset(%{name: name, description: description})
    |> Repo.insert(on_conflict: :replace_all, conflict_target: :name)

    message
  end
end
