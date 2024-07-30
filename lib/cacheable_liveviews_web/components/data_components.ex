defmodule CacheableLiveviewsWeb.DataComponents do
  use Phoenix.Component

  attr :product, :any, required: true

  def product_card(assigns) do
    ~H"""
    <div class="relative my-1">
      <div class="aspect-square border rounded-xl flex justify-center">
        <img src={"/images/#{@product.img_url}"} class="max-h-full max-w-full" />
      </div>
      <div>
        <p class="text-brand font-semibold text-lg"><%= to_string(@product.price) %></p>
        <p class="overflow-hidden whitespace-nowrap text-ellipsis text-zinc-600 font-semibold">
          <%= @product.name %>
        </p>
        <p class="">⭐ <%= @product.rating %></p>
      </div>
      <p class="absolute -top-2 -right-1 z-100 rounded-xl bg-blue-400 px-1 text-white font-semibold">
        <%= @product.brand %>
      </p>
    </div>
    """
  end
end
