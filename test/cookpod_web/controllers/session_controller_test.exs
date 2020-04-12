defmodule CookpodWeb.SessionControllerTest do
  use CookpodWeb.ConnCase
  @username Application.get_env(:cookpod, :basic_auth)[:username]
  @password Application.get_env(:cookpod, :basic_auth)[:password]

  defp using_basic_auth(conn, username, password) do
    header_content = "Basic " <> Base.encode64("#{username}:#{password}")
    put_req_header(conn, "authorization", header_content)
  end

  test "GET /sessions", %{conn: conn} do
    conn =
      conn
      |> using_basic_auth(@username, @password)
      |> get("/sessions")

    assert html_response(conn, 200) =~ "You are not logged in"
  end

  test "GET /sessions/new", %{conn: conn} do
    conn =
      conn
      |> using_basic_auth(@username, @password)
      |> get("/sessions/new")

    assert html_response(conn, 200) =~ "Submit"
    assert html_response(conn, 200) =~ "Name"
    assert html_response(conn, 200) =~ "Password"
  end

  test "post /sessions/", %{conn: conn} do
    conn =
      conn
      |> using_basic_auth(@username, @password)
      |> put_req_header("content-type", "application/x-www-form-urlencoded")
      |> post("/sessions", "user%5Bname%5D=John&user%5Bpassword%5D=123")

    assert redirected_to(conn, 302) =~ "/"
    conn = get(recycle(conn), "/")
    assert html_response(conn, 200) =~ "You are logged in as John"
  end

  test "GET /sessions without basic auth credentials prevents access", %{conn: conn} do
    conn = get(conn, "/sessions")

    assert response(conn, 401) =~ "401 Unauthorized"
  end
end
