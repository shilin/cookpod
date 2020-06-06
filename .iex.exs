use QuickAlias, Cookpod
import_if_available(Ecto.Query)

defmodule H do
  def recipe() do
    Repo.one(from(r in Recipe, limit: 1))
  end
end
