defmodule CacheableLiveviews.Product do
  import Money.Sigil

  def top() do
    [
      %{
        id: 1,
        name: "Women's sunglasses",
        brand: "Ferragamo",
        price: ~M|269.90|EUR,
        img_url: "sunglasses.jpeg",
        rating: 4.8
      },
      %{
        id: 2,
        name: "Women's watch",
        brand: "Michael Kors",
        price: ~M|279.90|EUR,
        img_url: "watch.jpeg",
        rating: 4.9
      },
      %{
        id: 3,
        name: "Starry Nights Eau de Parfum 100 ml",
        brand: "Montale",
        price: ~M|144.90|EUR,
        img_url: "parfum.jpeg",
        rating: 5.0
      },
      %{
        id: 4,
        name: "Man Glacial Essence Eau de Parfum 60 ml",
        brand: "Bvlgari",
        price: ~M|82.90|EUR,
        img_url: "eau_de_toilette.jpeg",
        rating: 4.8
      },
      %{
        id: 5,
        name: "English Pear & Freesia Body & Hand Wash",
        brand: "Jo Malone London",
        price: ~M|43.90|EUR,
        img_url: "handwash.jpeg",
        rating: 4.7
      },
      %{
        id: 6,
        name: "Muses Marilyn Monroe",
        brand: "Montblanc",
        price: ~M|819.90|EUR,
        img_url: "stylo.jpeg",
        rating: 5.0
      }
    ]
  end

  def count_products() do
    :timer.sleep(2_500_000_000)

    1327
  end
end
