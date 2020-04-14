defmodule CookpodWeb.PageControllerTest do
  use CookpodWeb.ConnCase
  @username Application.get_env(:cookpod, :basic_auth)[:username]
  @password Application.get_env(:cookpod, :basic_auth)[:password]

  defp using_basic_auth(conn, username, password) do
    header_content = "Basic " <> Base.encode64("#{username}:#{password}")
    put_req_header(conn, "authorization", header_content)
  end

  test "GET /", %{conn: conn} do
    conn =
      conn
      |> using_basic_auth(@username, @password)
      |> get("/")

    assert html_response(conn, 200) =~ "Привет, Phoenix!"
  end

  test "GET / without basic auth credentials prevents access", %{conn: conn} do
    conn = get(conn, "/")

    assert response(conn, 401) =~ "401 Unauthorized"
  end
end
