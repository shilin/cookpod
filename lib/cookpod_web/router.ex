defmodule CookpodWeb.Router do
  use CookpodWeb, :router
  use Plug.ErrorHandler

  pipeline :browser do
    plug :accepts, ["html"]
    plug BasicAuth, use_config: {:cookpod, :basic_auth}
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :set_current_user
  end

  pipeline :protected do
    plug :browser
    plug CookpodWeb.AuthPlug
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", CookpodWeb do
    pipe_through :browser

    get "/", PageController, :index

    resources "/sessions", SessionController, singleton: true
    resources "/users", UserController, only: [:create, :new]
    resources "/recipes", RecipeController
  end

  scope "/", CookpodWeb do
    pipe_through [:protected]
    get "/terms", PageController, :terms
  end

  defp set_current_user(conn, _params) do
    current_user = get_session(conn, :current_user)
    assign(conn, :current_user, current_user)
  end

  def handle_errors(conn, %{kind: :error, reason: %Phoenix.Router.NoRouteError{}}) do
    conn
    |> fetch_session()
    |> fetch_flash()
    |> put_layout({CookpodWeb.LayoutView, :app})
    |> put_view(CookpodWeb.ErrorView)
    |> render("404.html")
  end

  def handle_errors(conn, %{kind: :error, reason: %Phoenix.ActionClauseError{}}) do
    conn
    |> fetch_session()
    |> fetch_flash()
    |> put_layout({CookpodWeb.LayoutView, :app})
    |> put_view(CookpodWeb.ErrorView)
    |> render("422.html")
  end

  def handle_errors(conn, _) do
    # TODO add Rollbar here
    conn
  end

  # Other scopes may use custom stacks.
  # scope "/api", CookpodWeb do
  #   pipe_through :api
  # end
end
