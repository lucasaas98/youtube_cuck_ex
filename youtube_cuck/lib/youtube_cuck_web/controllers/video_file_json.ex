defmodule YoutubeCuckWeb.VideoFileJSON do
  alias YoutubeCuck.Cuck.VideoFile

  @doc """
  Renders a list of video_file.
  """
  def index(%{video_file: video_file}) do
    %{data: for(video_file <- video_file, do: data(video_file))}
  end

  @doc """
  Renders a single video_file.
  """
  def show(%{video_file: video_file}) do
    %{data: data(video_file)}
  end

  defp data(%VideoFile{} = video_file) do
    %{
      id: video_file.id,
      video_path: video_file.video_path
    }
  end
end
