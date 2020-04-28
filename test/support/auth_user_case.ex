defmodule CookpodWeb.AuthUserCase do
  use ExUnit.CaseTemplate

  import Plug.Test
  import Plug.Conn

  @username Application.get_env(:cookpod, :basic_auth)[:username]
  @password Application.get_env(:cookpod, :basic_auth)[:password]

  using do
    quote do
      # Import conveniences for testing with connections
      use Phoenix.ConnTest
      alias CookpodWeb.Router.Helpers, as: Routes

      # The default endpoint for testing
      @endpoint CookpodWeb.Endpoint
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Cookpod.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Cookpod.Repo, {:shared, self()})
    end

    conn = Phoenix.ConnTest.build_conn()
    current_user = %{email: "user@a.com", password: "1234"}

    unless tags[:anon] do
      conn =
        conn
        |> init_test_session(current_user)
        |> using_basic_auth(@username, @password)

      {:ok, current_user: current_user, conn: conn}
    else
      {:ok, current_user: current_user, conn: conn}
    end
  end

  defp using_basic_auth(conn, username, password) do
    header_content = "Basic " <> Base.encode64("#{username}:#{password}")
    put_req_header(conn, "authorization", header_content)
  end
end
