defmodule CacheableLiveviews.User do
  alias CacheableLiveviews.Product

  def items_in_cart(_) do
    Product.top() |> Enum.take(2)
  end

  def list_notifications(_) do
    [
      %{id: 1, msg: "Msg 1"},
      %{id: 2, msg: "Msg 2"},
      %{id: 3, msg: "Msg 3"}
    ]
  end
end
