defmodule CacheableLiveviewsWeb.DataComponents do
  use Phoenix.Component

  alias Phoenix.LiveView.JS

  attr :product, :any, required: true

  def product_card(assigns) do
    ~H"""
    <div id={"product-#{@product.id}"} class="relative my-1">
      <div class="aspect-square border rounded-xl flex justify-center">
        <img src={"/images/#{@product.img_url}"} class="max-h-full max-w-full" />
      </div>
      <div>
        <p
          class="text-brand font-semibold text-lg"
          id={"price-#{@product.id}"}
          data-wiggle={animate_wiggle("#price-#{@product.id}")}
        >
          <%= to_string(@product.price) %>
        </p>
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

  def animate_wiggle(element_id) do
    JS.transition(%JS{}, "animate-wiggle", to: element_id, time: 200)
  end
end
