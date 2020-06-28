defmodule Cookpod.Hits do
  use GenServer

  def init(_init_hits) do
    :ets.new(:recipe_hits, [:named_table, write_concurrency: true, read_concurrency: true])
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
    :ets.update_counter(:recipe_hits, recipe_id, {2, 1}, {recipe_id, 0})
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
