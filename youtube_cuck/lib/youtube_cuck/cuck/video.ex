defmodule YoutubeCuck.Cuck.VideoStatus do
  use EctoEnum,
    type: :video_status,
    enums: [:created, :missing_download, :downloaded, :deleted]
end

defmodule YoutubeCuck.Cuck.Video do
  use Ecto.Schema
  import Ecto.Changeset
  alias YoutubeCuck.Cuck.VideoStatus

  @primary_key {:id, :id, autogenerate: true}
  schema "video" do
    field(:video_url, :string)
    field(:video_path, :string)
    field(:thumbnail_url, :string)
    field(:thumbnail_path, :string)
    field(:publication_date, :integer)
    field(:publication_date_human, :string)
    field(:rating, :float)
    field(:title, :string)
    field(:view_count, :integer)
    field(:description, :string)
    field(:channel, :string)
    field(:status, VideoStatus, default: :created)

    timestamps()
  end

  @doc false
  def changeset(video, attrs) do
    video
    |> cast(attrs, [
      :video_url,
      :video_path,
      :thumbnail_url,
      :thumbnail_path,
      :publication_date,
      :publication_date_human,
      :rating,
      :title,
      :view_count,
      :description,
      :channel,
      :status
    ])
    |> unique_constraint(:video_url)
    |> validate_required([:video_url, :thumbnail_url])
  end
end
