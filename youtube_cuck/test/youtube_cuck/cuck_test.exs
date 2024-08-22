defmodule YoutubeCuck.CuckTest do
  use YoutubeCuck.DataCase

  describe "video" do
    alias YoutubeCuck.Cuck.Video

    import YoutubeCuck.CuckFixtures

    @invalid_attrs %{status: nil, description: nil, title: nil, url: nil, views: nil}

    test "list_video/0 returns all video" do
      video = video_fixture()
      assert Cuck.list_video() == [video]
    end

    test "get_video!/1 returns the video with given id" do
      video = video_fixture()
      assert Cuck.get_video!(video.id) == video
    end

    test "create_video/1 with valid data creates a video" do
      valid_attrs = %{
        status: :regular,
        description: "some description",
        title: "some title",
        url: "some url",
        views: 42
      }

      assert {:ok, %Video{} = video} = Cuck.create_video(valid_attrs)
      assert video.status == :regular
      assert video.description == "some description"
      assert video.title == "some title"
      assert video.url == "some url"
      assert video.views == 42
    end

    test "create_video/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Cuck.create_video(@invalid_attrs)
    end

    test "update_video/2 with valid data updates the video" do
      video = video_fixture()

      update_attrs = %{
        status: :livestream,
        description: "some updated description",
        title: "some updated title",
        url: "some updated url",
        views: 43
      }

      assert {:ok, %Video{} = video} = Cuck.update_video(video, update_attrs)
      assert video.status == :livestream
      assert video.description == "some updated description"
      assert video.title == "some updated title"
      assert video.url == "some updated url"
      assert video.views == 43
    end

    test "update_video/2 with invalid data returns error changeset" do
      video = video_fixture()
      assert {:error, %Ecto.Changeset{}} = Cuck.update_video(video, @invalid_attrs)
      assert video == Cuck.get_video!(video.id)
    end

    test "delete_video/1 deletes the video" do
      video = video_fixture()
      assert {:ok, %Video{}} = Cuck.delete_video(video)
      assert_raise Ecto.NoResultsError, fn -> Cuck.get_video!(video.id) end
    end

    test "change_video/1 returns a video changeset" do
      video = video_fixture()
      assert %Ecto.Changeset{} = Cuck.change_video(video)
    end
  end

  describe "channel" do
    alias YoutubeCuck.Cuck.Channel

    import YoutubeCuck.CuckFixtures

    @invalid_attrs %{title: nil, external_id: nil, subscriber_count: nil}

    test "list_channel/0 returns all channel" do
      channel = channel_fixture()
      assert Cuck.list_channel() == [channel]
    end

    test "get_channel!/1 returns the channel with given id" do
      channel = channel_fixture()
      assert Cuck.get_channel!(channel.id) == channel
    end

    test "create_channel/1 with valid data creates a channel" do
      valid_attrs = %{title: "some title", external_id: "some external_id", subscriber_count: 42}

      assert {:ok, %Channel{} = channel} = Cuck.create_channel(valid_attrs)
      assert channel.title == "some title"
      assert channel.external_id == "some external_id"
      assert channel.subscriber_count == 42
    end

    test "create_channel/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Cuck.create_channel(@invalid_attrs)
    end

    test "update_channel/2 with valid data updates the channel" do
      channel = channel_fixture()

      update_attrs = %{
        title: "some updated title",
        external_id: "some updated external_id",
        subscriber_count: 43
      }

      assert {:ok, %Channel{} = channel} = Cuck.update_channel(channel, update_attrs)
      assert channel.title == "some updated title"
      assert channel.external_id == "some updated external_id"
      assert channel.subscriber_count == 43
    end

    test "update_channel/2 with invalid data returns error changeset" do
      channel = channel_fixture()
      assert {:error, %Ecto.Changeset{}} = Cuck.update_channel(channel, @invalid_attrs)
      assert channel == Cuck.get_channel!(channel.id)
    end

    test "delete_channel/1 deletes the channel" do
      channel = channel_fixture()
      assert {:ok, %Channel{}} = Cuck.delete_channel(channel)
      assert_raise Ecto.NoResultsError, fn -> Cuck.get_channel!(channel.id) end
    end

    test "change_channel/1 returns a channel changeset" do
      channel = channel_fixture()
      assert %Ecto.Changeset{} = Cuck.change_channel(channel)
    end
  end

  describe "video_file" do
    alias YoutubeCuck.Cuck.VideoFile

    import YoutubeCuck.CuckFixtures

    @invalid_attrs %{video_path: nil}

    test "list_video_file/0 returns all video_file" do
      video_file = video_file_fixture()
      assert Cuck.list_video_file() == [video_file]
    end

    test "get_video_file!/1 returns the video_file with given id" do
      video_file = video_file_fixture()
      assert Cuck.get_video_file!(video_file.id) == video_file
    end

    test "create_video_file/1 with valid data creates a video_file" do
      valid_attrs = %{video_path: "some video_path"}

      assert {:ok, %VideoFile{} = video_file} = Cuck.create_video_file(valid_attrs)
      assert video_file.video_path == "some video_path"
    end

    test "create_video_file/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Cuck.create_video_file(@invalid_attrs)
    end

    test "update_video_file/2 with valid data updates the video_file" do
      video_file = video_file_fixture()
      update_attrs = %{video_path: "some updated video_path"}

      assert {:ok, %VideoFile{} = video_file} = Cuck.update_video_file(video_file, update_attrs)
      assert video_file.video_path == "some updated video_path"
    end

    test "update_video_file/2 with invalid data returns error changeset" do
      video_file = video_file_fixture()
      assert {:error, %Ecto.Changeset{}} = Cuck.update_video_file(video_file, @invalid_attrs)
      assert video_file == Cuck.get_video_file!(video_file.id)
    end

    test "delete_video_file/1 deletes the video_file" do
      video_file = video_file_fixture()
      assert {:ok, %VideoFile{}} = Cuck.delete_video_file(video_file)
      assert_raise Ecto.NoResultsError, fn -> Cuck.get_video_file!(video_file.id) end
    end

    test "change_video_file/1 returns a video_file changeset" do
      video_file = video_file_fixture()
      assert %Ecto.Changeset{} = Cuck.change_video_file(video_file)
    end
  end

  describe "thumbnail_file" do
    alias YoutubeCuck.Cuck.ThumbnailFile

    import YoutubeCuck.CuckFixtures

    @invalid_attrs %{thumbnail_path: nil}

    test "list_thumbnail_file/0 returns all thumbnail_file" do
      thumbnail_file = thumbnail_file_fixture()
      assert Cuck.list_thumbnail_file() == [thumbnail_file]
    end

    test "get_thumbnail_file!/1 returns the thumbnail_file with given id" do
      thumbnail_file = thumbnail_file_fixture()
      assert Cuck.get_thumbnail_file!(thumbnail_file.id) == thumbnail_file
    end

    test "create_thumbnail_file/1 with valid data creates a thumbnail_file" do
      valid_attrs = %{thumbnail_path: "some thumbnail_path"}

      assert {:ok, %ThumbnailFile{} = thumbnail_file} = Cuck.create_thumbnail_file(valid_attrs)
      assert thumbnail_file.thumbnail_path == "some thumbnail_path"
    end

    test "create_thumbnail_file/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Cuck.create_thumbnail_file(@invalid_attrs)
    end

    test "update_thumbnail_file/2 with valid data updates the thumbnail_file" do
      thumbnail_file = thumbnail_file_fixture()
      update_attrs = %{thumbnail_path: "some updated thumbnail_path"}

      assert {:ok, %ThumbnailFile{} = thumbnail_file} =
               Cuck.update_thumbnail_file(thumbnail_file, update_attrs)

      assert thumbnail_file.thumbnail_path == "some updated thumbnail_path"
    end

    test "update_thumbnail_file/2 with invalid data returns error changeset" do
      thumbnail_file = thumbnail_file_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Cuck.update_thumbnail_file(thumbnail_file, @invalid_attrs)

      assert thumbnail_file == Cuck.get_thumbnail_file!(thumbnail_file.id)
    end

    test "delete_thumbnail_file/1 deletes the thumbnail_file" do
      thumbnail_file = thumbnail_file_fixture()
      assert {:ok, %ThumbnailFile{}} = Cuck.delete_thumbnail_file(thumbnail_file)
      assert_raise Ecto.NoResultsError, fn -> Cuck.get_thumbnail_file!(thumbnail_file.id) end
    end

    test "change_thumbnail_file/1 returns a thumbnail_file changeset" do
      thumbnail_file = thumbnail_file_fixture()
      assert %Ecto.Changeset{} = Cuck.change_thumbnail_file(thumbnail_file)
    end
  end
end
