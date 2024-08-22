defmodule YoutubeCuckWeb.ThumbnailFileJSON do
  alias YoutubeCuck.Cuck.ThumbnailFile

  @doc """
  Renders a list of thumbnail_file.
  """
  def index(%{thumbnail_file: thumbnail_file}) do
    %{data: for(thumbnail_file <- thumbnail_file, do: data(thumbnail_file))}
  end

  @doc """
  Renders a single thumbnail_file.
  """
  def show(%{thumbnail_file: thumbnail_file}) do
    %{data: data(thumbnail_file)}
  end

  defp data(%ThumbnailFile{} = thumbnail_file) do
    %{
      id: thumbnail_file.id,
      thumbnail_path: thumbnail_file.thumbnail_path
    }
  end
end
