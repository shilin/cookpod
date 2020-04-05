defmodule CookpodWeb.PageControllerTest do
  use CookpodWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Welcome to BADGE Error Phoenix!"
  end
end
