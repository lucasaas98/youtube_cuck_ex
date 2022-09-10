defmodule YoutubeCuck.Repo do
  use Ecto.Repo,
    otp_app: :youtube_cuck,
    adapter: Ecto.Adapters.Postgres

  use Scrivener, page_size: 35
end
