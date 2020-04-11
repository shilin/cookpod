defmodule CookpodWeb.PageController do
  use CookpodWeb, :controller

  action_fallback CookpodWeb.FallbackPlug

  def index(_conn, _params) do
    # render(conn, "index.html")
    :ok
  end

  def terms(conn, _params) do
    render(conn, "terms.html")
  end
end
