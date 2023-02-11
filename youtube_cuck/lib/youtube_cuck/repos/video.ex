defmodule YoutubeCuck.Repos.Video do
  @moduledoc """
  The Video context.
  """

  import Ecto.Query, warn: false
  alias YoutubeCuck.Repo

  alias YoutubeCuck.Cuck.Video

  def list_videos() do
    Repo.all(Video)
  end

  def list_downloaded_videos() do
    from(v in Video, where: v.status in [:missing_download, :created])
    |> Repo.all()
  end

  def list_videos_to_remove(datetime) do
    Video
    |> where([v], v.publication_date < ^datetime)
    |> where(keep: false)
    |> Repo.all()
  end

  def list_downloaded_videos_by_channel(channel_id) do
    Video
    |> where(channel_id: ^channel_id)
    |> where([v], v.status in [:downloaded, :deleted])
    |> Repo.all()
  end

  def create_video(attrs \\ %{}) do
    %Video{}
    |> Video.changeset(attrs)
    |> Repo.insert()
  end

  def update_video(%Video{} = video, attrs) do
    video
    |> Video.changeset(attrs)
    |> Repo.update()
  end

  def delete_video(%Video{} = video) do
    Repo.delete(video)
  end
end
