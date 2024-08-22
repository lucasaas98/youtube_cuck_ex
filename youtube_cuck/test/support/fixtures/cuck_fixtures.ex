defmodule YoutubeCuck.CuckFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `YoutubeCuck.Cuck` context.
  """

  @doc """
  Generate a unique video url.
  """
  def unique_video_url, do: "some url#{System.unique_integer([:positive])}"

  @doc """
  Generate a video.
  """
  def video_fixture(attrs \\ %{}) do
    {:ok, video} =
      attrs
      |> Enum.into(%{
        description: "some description",
        status: :regular,
        title: "some title",
        url: unique_video_url(),
        views: 42
      })
      |> YoutubeCuck.Cuck.create_video()

    video
  end

  @doc """
  Generate a channel.
  """
  def channel_fixture(attrs \\ %{}) do
    {:ok, channel} =
      attrs
      |> Enum.into(%{
        external_id: "some external_id",
        subscriber_count: 42,
        title: "some title"
      })
      |> YoutubeCuck.Cuck.create_channel()

    channel
  end

  @doc """
  Generate a video_file.
  """
  def video_file_fixture(attrs \\ %{}) do
    {:ok, video_file} =
      attrs
      |> Enum.into(%{
        video_path: "some video_path"
      })
      |> YoutubeCuck.Cuck.create_video_file()

    video_file
  end

  @doc """
  Generate a thumbnail_file.
  """
  def thumbnail_file_fixture(attrs \\ %{}) do
    {:ok, thumbnail_file} =
      attrs
      |> Enum.into(%{
        thumbnail_path: "some thumbnail_path"
      })
      |> YoutubeCuck.Cuck.create_thumbnail_file()

    thumbnail_file
  end
end
