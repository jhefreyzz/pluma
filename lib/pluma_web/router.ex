defmodule PlumaWeb.Router do
  use PlumaWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug PlumaWeb.Plug.AssignCurrentUser
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PlumaWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/posts", PostController
  end

  scope "/auth", PlumaWeb do
    pipe_through :browser

    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
    delete "/sign_out", AuthController, :delete
  end

  # Other scopes may use custom stacks.
  # scope "/api", PlumaWeb do
  #   pipe_through :api
  # end
end
