defmodule CacheableLiveviewsWeb.Router do
  use CacheableLiveviewsWeb, :router

  @caching_opts %{store: :http_cache_store_memory}

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :protect_from_forgery
    plug :put_root_layout, html: {CacheableLiveviewsWeb.Layouts, :root}
    plug :put_secure_browser_headers
  end

  pipeline :caching do
    plug PlugHTTPCache, @caching_opts
    plug CacheableLiveviewsWeb.Plug.CacheLiveviewResponse, 60 * 60 * 6
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", CacheableLiveviewsWeb do
    pipe_through :browser

    get "/login", LoginController, :login

    live_session :default do
      pipe_through :caching

      live "/", MainLive.Index
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", CacheableLiveviewsWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard in development
  if Application.compile_env(:cacheable_liveviews, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: CacheableLiveviewsWeb.Telemetry
    end
  end
end
