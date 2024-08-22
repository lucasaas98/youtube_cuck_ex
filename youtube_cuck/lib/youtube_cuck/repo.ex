defmodule YoutubeCuck.Repo do
  use Ecto.Repo,
    otp_app: :youtube_cuck,
    adapter: Ecto.Adapters.Postgres
end
