defmodule YoutubeCuckWeb.ChannelJSON do
  alias YoutubeCuck.Cuck.Channel

  @doc """
  Renders a list of channel.
  """
  def index(%{channel: channel}) do
    %{data: for(channel <- channel, do: data(channel))}
  end

  @doc """
  Renders a single channel.
  """
  def show(%{channel: channel}) do
    %{data: data(channel)}
  end

  defp data(%Channel{} = channel) do
    %{
      id: channel.id,
      title: channel.title,
      external_id: channel.external_id,
      subscriber_count: channel.subscriber_count
    }
  end
end
