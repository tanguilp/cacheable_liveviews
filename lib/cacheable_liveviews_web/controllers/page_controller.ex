defmodule CacheableLiveviewsWeb.PageController do
  use CacheableLiveviewsWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end

  def userhome(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :userhome, layout: false)
  end
end
