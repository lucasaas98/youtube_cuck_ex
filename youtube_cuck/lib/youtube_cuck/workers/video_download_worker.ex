defmodule YoutubeCuck.Workers.VideoDownloadWorker do
  use Oban.Worker,
    max_attempts: 3

  require Logger

  alias YoutubeCuck.Repos.Video, as: VideoRepo

  @impl Oban.Worker
  def perform(%Oban.Job{args: %{"video" => video} = _args}) do
    video_url = video["video_url"]

    {output, exit_code} = System.cmd("yt-dlp", ["--list-formats", video_url])

    if exit_code > 0 do
      raise RuntimeError, message: "Listing formats failed for video #{video_url}"
    end

    if String.contains?(output, "m3u8") do
      Logger.info("The video is a live stream")

      raise RuntimeError,
        message: "Skipping download for video #{video_url} since it's a livestream"
    else
      Logger.info("It's an actual video, downloading")

      root_folder = Application.get_env(:orchestrator, :root_folder)
      path = video["video_id"]

      # download video
      video_path = "#{root_folder}/data/videos/#{path}"
      {_output, exit_code} =
        System.cmd("yt-dlp", [
          "-f",
          "'bestvideo[height<=1080][ext=mp4]+bestaudio[ext=m4a]/best[height<=1080]mp4'",
          "-o",
          video_path
          "--fixup",
          "force",
          video_url
        ])


      if exit_code > 0 do
        raise RuntimeError, message: "Downloading video #{video_url} failed."
      end

      # download thumbnail
      thumbnail_url = video["thumbnail_url"]
      thumbnail_path = "#{root_folder}/data/videos/#{path}.jpg"
      %HTTPoison.Response{body: body} = HTTPoison.get!(thumbnail_url)
      File.write!(thumbnail_path, body)

      VideoRepo.update_video(video, %{video_path: video_path, thumbnail_path: thumbnail_path})
    end
  end
end
