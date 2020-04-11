defmodule CookpodWeb.PageController do
  use CookpodWeb, :controller

  action_fallback :fallback

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def terms(conn, _params) do
    render(conn, "terms.html")
  end

  defp fallback(conn, _opts) do
    send_resp(conn, 200, "I am a func fallback")
  end
end
