defmodule Cookpod.Hits do
  use GenServer

  def init(_init_hits) do
    {:ok, %{}}
  end

  def start_link(arg) do
    GenServer.start_link(__MODULE__, arg, name: MyHits)
  end

  # def add(pid, item) do  
  #   GenServer.call(pid, {:add, item})
  # end

  def increment(recipe_id) do
    GenServer.cast(MyHits, {:"$increment", recipe_id})
  end

  # handle_call - для обработки синхронных вызовов.
  def handle_call(msg, _from, state) do
    case msg do
      :"$hits" ->
        {:reply, state, state}

      _msg_body ->
        {:noreply, state}
    end
  end

  def state do
    GenServer.call(MyHits, :"$hits")
  end

  # handle_cast - для обработки асинхронных вызовов.
  def handle_cast(msg, state) do
    case msg do
      {:"$increment", recipe_id} ->
        new_state = Map.update(state, recipe_id, 0, &(&1 + 1))
        {:noreply, new_state}

      _msg_body ->
        {:noreply, state}
    end
  end

  # handle_info -  для обработки сообщений, которые были посланы ему просто как процессу через send
  def handle_info do
  end
end
