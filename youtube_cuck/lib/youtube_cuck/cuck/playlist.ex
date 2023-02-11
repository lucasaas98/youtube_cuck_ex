defmodule YoutubeCuck.Cuck.Playlist do
  use Ecto.Schema
  import Ecto.Changeset
  alias YoutubeCuck.Cuck.Video

  @primary_key {:id, :id, autogenerate: true}
  schema "playlist" do
    field(:name, :string)

    has_many(:videos, Video)

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(playlist, attrs) do
    playlist
    |> cast(attrs, [
      :name,
      :videos
    ])
    |> unique_constraint(:name)
    |> validate_required([:name])
  end
end
