defmodule YoutubeCuckWeb.ChannelControllerTest do
  use YoutubeCuckWeb.ConnCase

  import YoutubeCuck.CuckFixtures

  alias YoutubeCuck.Cuck.Channel

  @create_attrs %{
    title: "some title",
    external_id: "some external_id",
    subscriber_count: 42
  }
  @update_attrs %{
    title: "some updated title",
    external_id: "some updated external_id",
    subscriber_count: 43
  }
  @invalid_attrs %{title: nil, external_id: nil, subscriber_count: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all channel", %{conn: conn} do
      conn = get(conn, ~p"/api/channel")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create channel" do
    test "renders channel when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/channel", channel: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/channel/#{id}")

      assert %{
               "id" => ^id,
               "external_id" => "some external_id",
               "subscriber_count" => 42,
               "title" => "some title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/channel", channel: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update channel" do
    setup [:create_channel]

    test "renders channel when data is valid", %{conn: conn, channel: %Channel{id: id} = channel} do
      conn = put(conn, ~p"/api/channel/#{channel}", channel: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/channel/#{id}")

      assert %{
               "id" => ^id,
               "external_id" => "some updated external_id",
               "subscriber_count" => 43,
               "title" => "some updated title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, channel: channel} do
      conn = put(conn, ~p"/api/channel/#{channel}", channel: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete channel" do
    setup [:create_channel]

    test "deletes chosen channel", %{conn: conn, channel: channel} do
      conn = delete(conn, ~p"/api/channel/#{channel}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/channel/#{channel}")
      end
    end
  end

  defp create_channel(_) do
    channel = channel_fixture()
    %{channel: channel}
  end
end
