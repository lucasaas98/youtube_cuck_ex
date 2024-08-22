defmodule YoutubeCuckWeb.ThumbnailFileController do
  use YoutubeCuckWeb, :controller

  alias YoutubeCuck.Cuck
  alias YoutubeCuck.Cuck.ThumbnailFile

  action_fallback YoutubeCuckWeb.FallbackController

  def index(conn, _params) do
    thumbnail_file = Cuck.list_thumbnail_file()
    render(conn, :index, thumbnail_file: thumbnail_file)
  end

  def create(conn, %{"thumbnail_file" => thumbnail_file_params}) do
    with {:ok, %ThumbnailFile{} = thumbnail_file} <-
           Cuck.create_thumbnail_file(thumbnail_file_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/thumbnail_file/#{thumbnail_file}")
      |> render(:show, thumbnail_file: thumbnail_file)
    end
  end

  def show(conn, %{"id" => id}) do
    thumbnail_file = Cuck.get_thumbnail_file!(id)
    render(conn, :show, thumbnail_file: thumbnail_file)
  end

  def update(conn, %{"id" => id, "thumbnail_file" => thumbnail_file_params}) do
    thumbnail_file = Cuck.get_thumbnail_file!(id)

    with {:ok, %ThumbnailFile{} = thumbnail_file} <-
           Cuck.update_thumbnail_file(thumbnail_file, thumbnail_file_params) do
      render(conn, :show, thumbnail_file: thumbnail_file)
    end
  end

  def delete(conn, %{"id" => id}) do
    thumbnail_file = Cuck.get_thumbnail_file!(id)

    with {:ok, %ThumbnailFile{}} <- Cuck.delete_thumbnail_file(thumbnail_file) do
      send_resp(conn, :no_content, "")
    end
  end
end
