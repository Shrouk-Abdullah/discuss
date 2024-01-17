defmodule DiscussWeb.Router do
  alias Hex.API.Auth
  use DiscussWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {DiscussWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", DiscussWeb do
    pipe_through :browser

    # get "/", TopicController, :showTopics
    # get "/topics/new", TopicController, :new
    # post "/topic", TopicController, :create
    # get "/topic/:id/edit", TopicController, :edit
    # put "/topic/:id", TopicController, :update
    # delete "/topic/:id", TopicController, :delete
    # => alternate to above (generate restful routes)
    resources "/topics", TopicController
  end

  # http://localhost:4000/auth
  scope "/auth", DiscussWeb do
    # before any request do preprocessing in request
    pipe_through :browser
    # (request) it's defines authomaticly, (provider) which is oath facebook or github etc
    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
  end

  # Other scopes may use custom stacks.
  # scope "/api", DiscussWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:discuss, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: DiscussWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
