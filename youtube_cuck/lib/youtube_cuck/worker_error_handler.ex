defmodule YoutubeCuck.WorkerErrorHandler do
  alias YoutubeCuck.Repos.Video, as: VideoRepo

  def handle_event(_, _, %{worker: "YoutubeCuck.Workers.VideoDownloadWorker"} = meta, _) do
    no_more_attempts? = meta.job.attempt == meta.job.max_attempts

    if no_more_attempts? do
      video = meta.args["video"]

      VideoRepo.update_video(video, %{status: :missing_download})
    end
  end
end
