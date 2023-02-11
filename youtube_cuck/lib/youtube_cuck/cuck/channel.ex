defmodule YoutubeCuck.Cuck.Channel do
  use Ecto.Schema
  import Ecto.Changeset
  alias YoutubeCuck.Cuck.Video

  @primary_key {:id, :id, autogenerate: true}
  schema "channel" do
    field(:name, :string)
    field(:rss_url, :string)
    field(:channel_url, :string)
    field(:subscribed, :boolean, default: false)
    field(:last_fetch, :utc_datetime)

    has_many(:videos, Video)
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(response, attrs) do
    response
    |> cast(attrs, [
      :name,
      :rss_url,
      :channel_url,
      :subscribed,
      :last_fetch
    ])
    |> unique_constraint(:rss_url)
    |> validate_required([:name, :rss_url, :channel_url])
  end
end
