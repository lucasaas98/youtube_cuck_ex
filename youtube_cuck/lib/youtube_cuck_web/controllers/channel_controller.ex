defmodule YoutubeCuckWeb.ChannelController do
  use YoutubeCuckWeb, :controller

  alias YoutubeCuck.Cuck
  alias YoutubeCuck.Cuck.Channel

  action_fallback YoutubeCuckWeb.FallbackController

  def index(conn, _params) do
    channel = Cuck.list_channel()
    render(conn, :index, channel: channel)
  end

  def create(conn, %{"channel" => channel_params}) do
    with {:ok, %Channel{} = channel} <- Cuck.create_channel(channel_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/channel/#{channel}")
      |> render(:show, channel: channel)
    end
  end

  def show(conn, %{"id" => id}) do
    channel = Cuck.get_channel!(id)
    render(conn, :show, channel: channel)
  end

  def update(conn, %{"id" => id, "channel" => channel_params}) do
    channel = Cuck.get_channel!(id)

    with {:ok, %Channel{} = channel} <- Cuck.update_channel(channel, channel_params) do
      render(conn, :show, channel: channel)
    end
  end

  def delete(conn, %{"id" => id}) do
    channel = Cuck.get_channel!(id)

    with {:ok, %Channel{}} <- Cuck.delete_channel(channel) do
      send_resp(conn, :no_content, "")
    end
  end
end
