defmodule YoutubeCuck.Workers.DeleteOldVideosWorker do
  use Oban.Worker,
    max_attempts: 3

  alias YoutubeCuck.Repos.Video, as: VideoRepo

  @max_time 1_296_000

  @impl Oban.Worker
  def perform(%Oban.Job{}) do
    min_datetime = DateTime.utc_now() |> DateTime.add(-@max_time)
    videos_to_delete = VideoRepo.list_videos_to_remove(min_datetime)

    videos_to_delete
    |> Enum.each(fn video ->
      # deleting the video
      if File.exists?(video.video_path) do
        File.rm(video.video_path)
      end

      # deleting the thumbnail
      if File.exists?(video.thumbnail_path) do
        File.rm(video.thumbnail_path)
      end

      # marking the video as deleted
      VideoRepo.update_video(video, %{status: :deleted})
    end)
  end
end
