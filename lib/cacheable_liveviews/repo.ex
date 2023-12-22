defmodule CacheableLiveviews.Repo do
  use Ecto.Repo,
    otp_app: :cacheable_liveviews,
    adapter: Ecto.Adapters.Postgres
end
