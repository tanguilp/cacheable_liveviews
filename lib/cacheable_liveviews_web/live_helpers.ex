defmodule CacheableLiveviewsWeb.LiveHelpers do
  import Phoenix.LiveView, only: [connected?: 1]
  import Phoenix.Component, only: [assign: 3]

  @user_session_key "user_id"

  def assign_private(socket, session, key, fun) do
    if connected?(socket) and is_map_key(session, @user_session_key) do
      assign(socket, key, fun.(session[@user_session_key]))
    else
      assign(socket, key, nil)
    end
  end
end
