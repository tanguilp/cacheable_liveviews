defmodule CacheableLiveviewsWeb.Plug.SetASessionNoMatterWhat do
  @behaviour Plug

  @some_key "🔑"
  @some_value "🥗"

  @impl true
  def init(opts), do: opts

  @impl true
  def call(conn, _opts) do
    Plug.Conn.put_session(conn, @some_key, @some_value)
  end
end
