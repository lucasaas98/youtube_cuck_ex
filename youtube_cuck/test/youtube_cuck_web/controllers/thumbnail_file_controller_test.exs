defmodule YoutubeCuckWeb.ThumbnailFileControllerTest do
  use YoutubeCuckWeb.ConnCase

  import YoutubeCuck.CuckFixtures

  alias YoutubeCuck.Cuck.ThumbnailFile

  @create_attrs %{
    thumbnail_path: "some thumbnail_path"
  }
  @update_attrs %{
    thumbnail_path: "some updated thumbnail_path"
  }
  @invalid_attrs %{thumbnail_path: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all thumbnail_file", %{conn: conn} do
      conn = get(conn, ~p"/api/thumbnail_file")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create thumbnail_file" do
    test "renders thumbnail_file when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/thumbnail_file", thumbnail_file: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/thumbnail_file/#{id}")

      assert %{
               "id" => ^id,
               "thumbnail_path" => "some thumbnail_path"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/thumbnail_file", thumbnail_file: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update thumbnail_file" do
    setup [:create_thumbnail_file]

    test "renders thumbnail_file when data is valid", %{
      conn: conn,
      thumbnail_file: %ThumbnailFile{id: id} = thumbnail_file
    } do
      conn = put(conn, ~p"/api/thumbnail_file/#{thumbnail_file}", thumbnail_file: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/thumbnail_file/#{id}")

      assert %{
               "id" => ^id,
               "thumbnail_path" => "some updated thumbnail_path"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, thumbnail_file: thumbnail_file} do
      conn = put(conn, ~p"/api/thumbnail_file/#{thumbnail_file}", thumbnail_file: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete thumbnail_file" do
    setup [:create_thumbnail_file]

    test "deletes chosen thumbnail_file", %{conn: conn, thumbnail_file: thumbnail_file} do
      conn = delete(conn, ~p"/api/thumbnail_file/#{thumbnail_file}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/thumbnail_file/#{thumbnail_file}")
      end
    end
  end

  defp create_thumbnail_file(_) do
    thumbnail_file = thumbnail_file_fixture()
    %{thumbnail_file: thumbnail_file}
  end
end
