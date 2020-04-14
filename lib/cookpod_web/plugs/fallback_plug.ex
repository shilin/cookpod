defmodule CookpodWeb.FallbackPlug do
  use Phoenix.Controller

  def init(opts), do: opts

  def call(conn, _opts) do
    send_resp(conn, 200, "I am a fallback")
  end
end
