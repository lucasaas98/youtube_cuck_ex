defmodule YoutubeCuckWeb.VideoJSON do
  alias YoutubeCuck.Cuck.Video

  @doc """
  Renders a list of video.
  """
  def index(%{video: video}) do
    %{data: for(video <- video, do: data(video))}
  end

  @doc """
  Renders a single video.
  """
  def show(%{video: video}) do
    %{data: data(video)}
  end

  defp data(%Video{} = video) do
    %{
      id: video.id,
      title: video.title,
      url: video.url,
      views: video.views,
      description: video.description,
      status: video.status
    }
  end
end
