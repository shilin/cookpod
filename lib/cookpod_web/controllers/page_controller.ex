defmodule CookpodWeb.PageController do
  use CookpodWeb, :controller

  # action_fallback :fallback

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def terms(conn, _params) do
    render(conn, "terms.html")
  end

  def hard_work(conn, _params) do
    id = gen_id()
    Task.async(fn ->
      Process.sleep(10000)
      CookpodWeb.Endpoint.broadcast!("demo:#{id}", "done", %{})
    end)

    render(conn, "hard_work.html", id: id)
  end

  defp gen_id() do
    7
    |> :crypto.strong_rand_bytes
    |> Base.encode16()
    |> String.downcase()
  end
  # defp fallback(conn, _opts) do
  #   send_resp(conn, 200, "I am a func fallback")
  # end
end
