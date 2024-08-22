defmodule YoutubeCuckWeb.VideoFileControllerTest do
  use YoutubeCuckWeb.ConnCase

  import YoutubeCuck.CuckFixtures

  alias YoutubeCuck.Cuck.VideoFile

  @create_attrs %{
    video_path: "some video_path"
  }
  @update_attrs %{
    video_path: "some updated video_path"
  }
  @invalid_attrs %{video_path: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all video_file", %{conn: conn} do
      conn = get(conn, ~p"/api/video_file")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create video_file" do
    test "renders video_file when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/video_file", video_file: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/video_file/#{id}")

      assert %{
               "id" => ^id,
               "video_path" => "some video_path"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/video_file", video_file: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update video_file" do
    setup [:create_video_file]

    test "renders video_file when data is valid", %{
      conn: conn,
      video_file: %VideoFile{id: id} = video_file
    } do
      conn = put(conn, ~p"/api/video_file/#{video_file}", video_file: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/video_file/#{id}")

      assert %{
               "id" => ^id,
               "video_path" => "some updated video_path"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, video_file: video_file} do
      conn = put(conn, ~p"/api/video_file/#{video_file}", video_file: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete video_file" do
    setup [:create_video_file]

    test "deletes chosen video_file", %{conn: conn, video_file: video_file} do
      conn = delete(conn, ~p"/api/video_file/#{video_file}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/video_file/#{video_file}")
      end
    end
  end

  defp create_video_file(_) do
    video_file = video_file_fixture()
    %{video_file: video_file}
  end
end
