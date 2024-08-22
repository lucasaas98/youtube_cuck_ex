defmodule YoutubeCuck.Cuck.Video do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "video" do
    field(:status, Ecto.Enum, values: [:regular, :livestream, :short, :premiere])
    field(:description, :string)
    field(:title, :string)
    field(:url, :string)
    field(:views, :integer)

    has_one(:video_file, YoutubeCuck.Cuck.VideoFile)
    has_one(:thumbnail_file, YoutubeCuck.Cuck.ThumbnailFile)
    belongs_to(:channel, YoutubeCuck.Cuck.Channel)

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(video, attrs) do
    video
    |> cast(attrs, [:title, :url, :views, :description, :status])
    |> validate_required([:title, :url, :views, :description, :status])
    |> unique_constraint(:url)
  end
end
