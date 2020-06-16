defmodule Cookpod.Recipes.Loot do
  use Broadway

  # import Ecto.Changeset
  alias Cookpod.Recipes.Recipe
  alias Cookpod.Repo
  alias Broadway.Message

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
      ],
      batchers: [
        default: [
          concurrency: 5,
          batch_size: 10,
          batch_timeout: 1000
        ]
      ]
    )
  end

  # def handle_message(_, message, _) do
  #   %{"name" => name, "description" => description} = Jason.decode!(message.data)
  #   # IO.inspect(Jason.decode!(message.data), label: "Got message")
  #   %Recipe{}
  #   |> Recipe.changeset(%{name: name, description: description})
  #   |> Repo.insert(on_conflict: :replace_all, conflict_target: :name)

  #   message
  # end

  def handle_message(_processor_name, message, _context) do
    message
    |> Message.update_data(fn data ->
      %{"name" => name, "description" => description} = Jason.decode!(data)
      %Recipe{} |> Recipe.changeset(%{name: name, description: description})
    end)
  end

  def handle_batch(_, messages, _batch_info, _context) do
    messages
    |> Enum.each(fn %{data: data} ->
      if data.valid? do
        Repo.insert(data, on_conflict: :replace_all, conflict_target: :name)
      end
    end)

    messages
  end
end
