defmodule CacheableLiveviewsWeb.MainLive.Index do
  use CacheableLiveviewsWeb, :live_view

  import Money.Sigil

  alias CacheableLiveviews.{Product, User}

  @impl true
  def mount(_params, session, socket) do
    socket =
      socket
      |> assign(:top_products, Product.top())
      |> assign(:nb_items_in_cart, nil)
      |> assign(:nb_notifications, nil)
      |> assign(:user_id, nil)
      |> assign_async(:nb_total_products, fn ->
        {:ok, %{nb_total_products: Product.count_products()}}
      end)

    if not connected?(socket) do
      socket
      |> assign(:deadmount, true)
      |> dead_mount()
    else
      socket
      |> assign(:deadmount, false)
      |> live_mount(session)
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

  defp live_mount(socket, session) do
    Process.send_after(self(), :change_price_live, 4_000)

    if authenticated?(session) do
      live_mount_authenticated(socket, session)
    else
      live_mount_anonymous(socket)
    end
  end

  defp live_mount_authenticated(socket, session) do
    # User is logged in
    user_id = session["user_id"]

    socket =
      socket
      |> assign(:user_id, user_id)
      |> assign(:nb_items_in_cart, User.items_in_cart(user_id) |> length())
      |> assign(:nb_notifications, User.list_notifications(user_id) |> length())

    {:ok, socket}
  end

  defp live_mount_anonymous(socket) do
    {:ok, socket}
  end

  defp authenticated?(%{"user_id" => _}), do: true
  defp authenticated?(_), do: false
end
