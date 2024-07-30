defmodule CacheableLiveviewsWeb.MainLive.Index do
  use CacheableLiveviewsWeb, :live_view

  import Money.Sigil

  alias CacheableLiveviews.Product

  @impl true
  def mount(_params, _session, socket) do
    if not connected?(socket) do
      dead_mount(socket)
    else
      live_mount(socket)
    end
  end

  defp dead_mount(socket) do
    {:ok, assign(socket, :top_products, Product.top())}
  end

  defp live_mount(socket) do
    top_products = update_in(Product.top(), [Access.at(1), :price], &Money.add!(&1, ~M|-7|EUR))

    {:ok, assign(socket, :top_products, top_products)}
  end
end
