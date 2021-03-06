defmodule CookpodWeb.Router do
  use CookpodWeb, :router
  import Phoenix.LiveDashboard.Router

  use Plug.ErrorHandler

  pipeline :browser do
    plug :accepts, ["html"]
    plug BasicAuth, use_config: {:cookpod, :basic_auth}
    plug :fetch_session
    # plug :fetch_flash
    plug :fetch_live_flash
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
    resources "/products", ProductController
    resources "/ingredients", IngredientController
  end

  scope "/", CookpodWeb do
    pipe_through [:protected]
    get "/terms", PageController, :terms
  end

  scope "/", CookpodWeb do
    pipe_through [:protected]
    live_dashboard("/dashboard", metrics: CookpodWeb.Telemetry)
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
  scope "/api/v2", CookpodWeb.Api, as: :api do
    pipe_through :api
    resources "/recipes", RecipeController
  end

  scope "/api/swagger" do
    forward "/", PhoenixSwagger.Plug.SwaggerUI, otp_app: :cookpod, swagger_file: "swagger.json"
  end

  def swagger_info do
    %{
      info: %{
        version: "1.0",
        title: "Cookpod"
      },
      basePath: "/api/v2"
    }
  end
end
