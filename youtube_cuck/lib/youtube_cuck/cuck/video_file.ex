defmodule YoutubeCuck.Cuck.VideoFile do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "video_file" do
    field(:video_path, :string)
    belongs_to(:video, YoutubeCuck.Cuck.Video)

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(video_file, attrs) do
    video_file
    |> cast(attrs, [:video_path])
    |> validate_required([:video_path])
  end
end
