defmodule YoutubeCuckWeb.VideoController do
  use YoutubeCuckWeb, :controller

  alias YoutubeCuck.Cuck
  alias YoutubeCuck.Cuck.Video

  action_fallback YoutubeCuckWeb.FallbackController

  def index(conn, _params) do
    video = Cuck.list_video()
    render(conn, :index, video: video)
  end

  def create(conn, %{"video" => video_params}) do
    with {:ok, %Video{} = video} <- Cuck.create_video(video_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/video/#{video}")
      |> render(:show, video: video)
    end
  end

  def show(conn, %{"id" => id}) do
    video = Cuck.get_video!(id)
    render(conn, :show, video: video)
  end

  def update(conn, %{"id" => id, "video" => video_params}) do
    video = Cuck.get_video!(id)

    with {:ok, %Video{} = video} <- Cuck.update_video(video, video_params) do
      render(conn, :show, video: video)
    end
  end

  def delete(conn, %{"id" => id}) do
    video = Cuck.get_video!(id)

    with {:ok, %Video{}} <- Cuck.delete_video(video) do
      send_resp(conn, :no_content, "")
    end
  end
end
