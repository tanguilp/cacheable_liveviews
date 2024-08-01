defmodule CacheableLiveviewsWeb.MainLive.Index do
  use CacheableLiveviewsWeb, :live_view

  import Money.Sigil

  alias CacheableLiveviews.Product

  @impl true
  def mount(_params, session, socket) do
    socket =
      socket
      |> assign(:top_products, Product.top())
      |> assign(:nb_items_in_cart, nil)
      |> assign(:nb_notifications, nil)
      |> assign(:user_id, nil)

    if not connected?(socket) do
      dead_mount(socket)
    else
      live_mount(session, socket)
    end
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

  defp dead_mount(socket) do
    {:ok, socket}
  end

  defp live_mount(params, socket) do
    Process.send_after(self(), :change_price_live, 2_000)

    {:ok, user_assign(params, socket)}
  end

  defp user_assign(%{"user_id" => user_id}, socket) do
    # User is logged in
    socket
    |> assign(:nb_items_in_cart, User.items_in_cart(user_id) |> length())
    |> assign(:nb_notifications, User.list_notifications(user_id) |> length())
  end

  defp user_assign(_, socket) do
    socket
  end
end
