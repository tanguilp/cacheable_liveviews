defmodule CacheableLiveviewsWeb.Plug.CacheLiveviewResponse do
  @behaviour Plug

  @impl true
  def init(duration_second) do
    duration_second
  end

  @impl true
  def call(conn, duration_second) do
    Plug.Conn.register_before_send(conn, set_cache_control_header(duration_second))
  end

  defp set_cache_control_header(duration_second) do
    fn
      %Plug.Conn{private: %{cache: true}} = conn ->
        PlugCacheControl.Helpers.put_cache_control(conn, [:public, s_maxage: duration_second])

      conn ->
        conn
    end
  end
end
