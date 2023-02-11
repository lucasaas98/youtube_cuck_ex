defmodule YoutubeCuck.Repos.Channel do
  @moduledoc """
  The Channel context.
  """

  import Ecto.Query, warn: false
  alias YoutubeCuck.Repo

  alias YoutubeCuck.Cuck.Channel

  def list_channels() do
    Repo.all(Channel)
  end

  def list_subscribed_channels() do
    from(c in Channel, where: c.subscribed)
    |> Repo.all()
  end

  def create_channel(attrs \\ %{}) do
    %Channel{}
    |> Channel.changeset(attrs)
    |> Repo.insert()
  end

  def update_channel(%Channel{} = channel, attrs) do
    channel
    |> Channel.changeset(attrs)
    |> Repo.update()
  end

  def delete_channel(%Channel{} = channel) do
    Repo.delete(channel)
  end
end
