defmodule YoutubeCuckWeb.VideoFileController do
  use YoutubeCuckWeb, :controller

  alias YoutubeCuck.Cuck
  alias YoutubeCuck.Cuck.VideoFile

  action_fallback YoutubeCuckWeb.FallbackController

  def index(conn, _params) do
    video_file = Cuck.list_video_file()
    render(conn, :index, video_file: video_file)
  end

  def create(conn, %{"video_file" => video_file_params}) do
    with {:ok, %VideoFile{} = video_file} <- Cuck.create_video_file(video_file_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/video_file/#{video_file}")
      |> render(:show, video_file: video_file)
    end
  end

  def show(conn, %{"id" => id}) do
    video_file = Cuck.get_video_file!(id)
    render(conn, :show, video_file: video_file)
  end

  def update(conn, %{"id" => id, "video_file" => video_file_params}) do
    video_file = Cuck.get_video_file!(id)

    with {:ok, %VideoFile{} = video_file} <- Cuck.update_video_file(video_file, video_file_params) do
      render(conn, :show, video_file: video_file)
    end
  end

  def delete(conn, %{"id" => id}) do
    video_file = Cuck.get_video_file!(id)

    with {:ok, %VideoFile{}} <- Cuck.delete_video_file(video_file) do
      send_resp(conn, :no_content, "")
    end
  end
end
