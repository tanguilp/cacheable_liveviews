defmodule CacheableLiveviewsWeb.LoginController do
  use CacheableLiveviewsWeb, :controller

  def login(conn, _params) do
    conn
    |> get_session()
    |> Map.has_key?("user_id")
    |> case do
      false ->
        conn
        |> put_session("user_id", 42)
        |> redirect(to: "/")

      true ->
        conn
        |> delete_session("user_id")
        |> redirect(to: "/")
    end
  end
end
