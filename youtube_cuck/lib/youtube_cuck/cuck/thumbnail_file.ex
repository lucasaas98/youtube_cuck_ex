defmodule YoutubeCuck.Cuck.ThumbnailFile do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "thumbnail_file" do
    field(:thumbnail_path, :string)
    belongs_to(:video, YoutubeCuck.Cuck.Video)

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(thumbnail_file, attrs) do
    thumbnail_file
    |> cast(attrs, [:thumbnail_path])
    |> validate_required([:thumbnail_path])
  end
end
