defmodule YoutubeCuck.Cuck do
  @moduledoc """
  The Cuck context.
  """

  import Ecto.Query, warn: false
  alias YoutubeCuck.Repo

  alias YoutubeCuck.Cuck.Video

  @doc """
  Returns the list of video.

  ## Examples

      iex> list_video()
      [%Video{}, ...]

  """
  def list_video do
    Repo.all(Video)
  end

  @doc """
  Gets a single video.

  Raises `Ecto.NoResultsError` if the Video does not exist.

  ## Examples

      iex> get_video!(123)
      %Video{}

      iex> get_video!(456)
      ** (Ecto.NoResultsError)

  """
  def get_video!(id), do: Repo.get!(Video, id)

  @doc """
  Creates a video.

  ## Examples

      iex> create_video(%{field: value})
      {:ok, %Video{}}

      iex> create_video(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_video(attrs \\ %{}) do
    %Video{}
    |> Video.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a video.

  ## Examples

      iex> update_video(video, %{field: new_value})
      {:ok, %Video{}}

      iex> update_video(video, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_video(%Video{} = video, attrs) do
    video
    |> Video.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a video.

  ## Examples

      iex> delete_video(video)
      {:ok, %Video{}}

      iex> delete_video(video)
      {:error, %Ecto.Changeset{}}

  """
  def delete_video(%Video{} = video) do
    Repo.delete(video)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking video changes.

  ## Examples

      iex> change_video(video)
      %Ecto.Changeset{data: %Video{}}

  """
  def change_video(%Video{} = video, attrs \\ %{}) do
    Video.changeset(video, attrs)
  end

  alias YoutubeCuck.Cuck.Channel

  @doc """
  Returns the list of channel.

  ## Examples

      iex> list_channel()
      [%Channel{}, ...]

  """
  def list_channel do
    Repo.all(Channel)
  end

  @doc """
  Gets a single channel.

  Raises `Ecto.NoResultsError` if the Channel does not exist.

  ## Examples

      iex> get_channel!(123)
      %Channel{}

      iex> get_channel!(456)
      ** (Ecto.NoResultsError)

  """
  def get_channel!(id), do: Repo.get!(Channel, id)

  @doc """
  Creates a channel.

  ## Examples

      iex> create_channel(%{field: value})
      {:ok, %Channel{}}

      iex> create_channel(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_channel(attrs \\ %{}) do
    %Channel{}
    |> Channel.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a channel.

  ## Examples

      iex> update_channel(channel, %{field: new_value})
      {:ok, %Channel{}}

      iex> update_channel(channel, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_channel(%Channel{} = channel, attrs) do
    channel
    |> Channel.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a channel.

  ## Examples

      iex> delete_channel(channel)
      {:ok, %Channel{}}

      iex> delete_channel(channel)
      {:error, %Ecto.Changeset{}}

  """
  def delete_channel(%Channel{} = channel) do
    Repo.delete(channel)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking channel changes.

  ## Examples

      iex> change_channel(channel)
      %Ecto.Changeset{data: %Channel{}}

  """
  def change_channel(%Channel{} = channel, attrs \\ %{}) do
    Channel.changeset(channel, attrs)
  end

  alias YoutubeCuck.Cuck.VideoFile

  @doc """
  Returns the list of video_file.

  ## Examples

      iex> list_video_file()
      [%VideoFile{}, ...]

  """
  def list_video_file do
    Repo.all(VideoFile)
  end

  @doc """
  Gets a single video_file.

  Raises `Ecto.NoResultsError` if the Video file does not exist.

  ## Examples

      iex> get_video_file!(123)
      %VideoFile{}

      iex> get_video_file!(456)
      ** (Ecto.NoResultsError)

  """
  def get_video_file!(id), do: Repo.get!(VideoFile, id)

  @doc """
  Creates a video_file.

  ## Examples

      iex> create_video_file(%{field: value})
      {:ok, %VideoFile{}}

      iex> create_video_file(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_video_file(attrs \\ %{}) do
    %VideoFile{}
    |> VideoFile.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a video_file.

  ## Examples

      iex> update_video_file(video_file, %{field: new_value})
      {:ok, %VideoFile{}}

      iex> update_video_file(video_file, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_video_file(%VideoFile{} = video_file, attrs) do
    video_file
    |> VideoFile.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a video_file.

  ## Examples

      iex> delete_video_file(video_file)
      {:ok, %VideoFile{}}

      iex> delete_video_file(video_file)
      {:error, %Ecto.Changeset{}}

  """
  def delete_video_file(%VideoFile{} = video_file) do
    Repo.delete(video_file)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking video_file changes.

  ## Examples

      iex> change_video_file(video_file)
      %Ecto.Changeset{data: %VideoFile{}}

  """
  def change_video_file(%VideoFile{} = video_file, attrs \\ %{}) do
    VideoFile.changeset(video_file, attrs)
  end

  alias YoutubeCuck.Cuck.ThumbnailFile

  @doc """
  Returns the list of thumbnail_file.

  ## Examples

      iex> list_thumbnail_file()
      [%ThumbnailFile{}, ...]

  """
  def list_thumbnail_file do
    Repo.all(ThumbnailFile)
  end

  @doc """
  Gets a single thumbnail_file.

  Raises `Ecto.NoResultsError` if the Thumbnail file does not exist.

  ## Examples

      iex> get_thumbnail_file!(123)
      %ThumbnailFile{}

      iex> get_thumbnail_file!(456)
      ** (Ecto.NoResultsError)

  """
  def get_thumbnail_file!(id), do: Repo.get!(ThumbnailFile, id)

  @doc """
  Creates a thumbnail_file.

  ## Examples

      iex> create_thumbnail_file(%{field: value})
      {:ok, %ThumbnailFile{}}

      iex> create_thumbnail_file(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_thumbnail_file(attrs \\ %{}) do
    %ThumbnailFile{}
    |> ThumbnailFile.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a thumbnail_file.

  ## Examples

      iex> update_thumbnail_file(thumbnail_file, %{field: new_value})
      {:ok, %ThumbnailFile{}}

      iex> update_thumbnail_file(thumbnail_file, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_thumbnail_file(%ThumbnailFile{} = thumbnail_file, attrs) do
    thumbnail_file
    |> ThumbnailFile.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a thumbnail_file.

  ## Examples

      iex> delete_thumbnail_file(thumbnail_file)
      {:ok, %ThumbnailFile{}}

      iex> delete_thumbnail_file(thumbnail_file)
      {:error, %Ecto.Changeset{}}

  """
  def delete_thumbnail_file(%ThumbnailFile{} = thumbnail_file) do
    Repo.delete(thumbnail_file)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking thumbnail_file changes.

  ## Examples

      iex> change_thumbnail_file(thumbnail_file)
      %Ecto.Changeset{data: %ThumbnailFile{}}

  """
  def change_thumbnail_file(%ThumbnailFile{} = thumbnail_file, attrs \\ %{}) do
    ThumbnailFile.changeset(thumbnail_file, attrs)
  end
end
