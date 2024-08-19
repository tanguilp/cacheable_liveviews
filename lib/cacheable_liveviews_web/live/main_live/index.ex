defmodule CacheableLiveviewsWeb.MainLive.Index do
  use CacheableLiveviewsWeb, :live_view

  import Money.Sigil

  alias CacheableLiveviews.{Product, User}

  @user_session_key "user_id"

  @impl true
  def mount(_params, session, socket) do
    socket =
      socket
      |> assign(:top_products, Product.top())
      |> assign(:connected?, connected?(socket))
      |> assign(:authenticated?, is_map_key(session, @user_session_key))
      |> assign_private(session, :nb_items_in_cart, &get_nb_items_in_cart/1)
      |> assign_private(session, :nb_notifications, &get_nb_notifications/1)
      |> assign_async(:nb_total_products, &get_nb_total_products/0)

    if not connected?(socket) do
      static_mount(socket)
    else
      live_mount(socket)
    end
  end

  defp static_mount(socket) do
    # Nothing more to do
    {:ok, socket}
  end

  defp live_mount(socket) do
    # In real life we would subscribe to a a Phoenix channel to get price updates
    Process.send_after(self(), :change_price_live, 4_000)

    {:ok, socket}
  end

  @impl true
  def handle_info(:change_price_live, socket) do
    top_products = update_in(Product.top(), [Access.at(1), :price], &Money.add!(&1, ~M|-7|EUR))

    socket =
      socket
      |> assign(:top_products, top_products)
      |> push_event("wiggle", %{id: "price-2"})

    {:noreply, socket}
  end

  defp get_nb_items_in_cart(user_id), do: user_id |> User.items_in_cart() |> length()
  defp get_nb_notifications(user_id), do: user_id |> User.list_notifications() |> length()
  defp get_nb_total_products(), do: {:ok, %{nb_total_products: Product.count_products()}}
end
