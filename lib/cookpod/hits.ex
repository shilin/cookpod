defmodule Cookpod.Hits do
  use GenServer

  def init(_init_hits) do
    :ets.new(:recipe_hits, [:named_table, read_concurrency: true])
    {:ok, %{}}
  end

  def start_link(arg) do
    GenServer.start_link(__MODULE__, arg, name: MyHits)
  end

  def increment(recipe_id) do
    GenServer.cast(MyHits, {:"$increment", recipe_id})
  end

  # handle_call - для обработки синхронных вызовов.
  def handle_call(_msg, _from, state) do
    # case msg do
    #   :"$hits" ->
    #     {:reply, tab2map(:recipe_hits), state}

    #   _msg_body ->
    #     {:noreply, state}
    # end
    {:noreply, state}
  end

  # handle_cast - для обработки асинхронных вызовов.
  def handle_cast(msg, state) do
    case msg do
      {:"$increment", recipe_id} ->
        increment_hits(recipe_id)
        {:noreply, state}

      _msg_body ->
        {:noreply, state}
    end
  end

  defp increment_hits(recipe_id) do
    exists = length(:ets.lookup(:recipe_hits, recipe_id))

    if exists > 0 do
      [{_, current_hits}] = :ets.lookup(:recipe_hits, recipe_id)
      :ets.insert(:recipe_hits, {recipe_id, current_hits + 1})
      [{_, new_hits}] = :ets.lookup(:recipe_hits, recipe_id)
    else
      :ets.insert(:recipe_hits, {recipe_id, 1})
      [{_, current_hits}] = :ets.lookup(:recipe_hits, recipe_id)
      IO.puts(current_hits)
    end
  end

  def tab2map(table) do
    case :ets.whereis(table) do
      :undefiend ->
        %{}

      _ ->
        hits_list = :ets.tab2list(table)
        Enum.into(hits_list, %{})
    end
  end

  # handle_info -  для обработки сообщений, которые были посланы ему просто как процессу через send
  def handle_info do
  end
end
