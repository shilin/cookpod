defmodule CookpodWeb.DemoChannel do
  use CookpodWeb, :channel

  require Logger

  def join("demo:lobby", payload, socket) do
    if authorized?(payload) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def join(_, payload, socket) do
    if authorized?(payload) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", _payload, socket) do
    {:reply, {:ok, %{from_server: "pong!"}}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (demo:lobby).
  def handle_in("shout", payload, socket) do
    broadcast(socket, "shout", payload)
    {:noreply, socket}
  end

  def handle_in(any, payload, socket) do
    Logger.debug("Message from the client " <> inspect(any))
    Logger.debug("Payload from the client " <> inspect(payload))
    # broadcast socket, "got #{any} from client", payload
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
