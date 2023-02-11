defmodule YoutubeCuck.Repo.Migrations.AddVideoTable do
  use Ecto.Migration
  alias YoutubeCuck.Cuck.VideoStatus

  def change do
    VideoStatus.create_type()

    create table(:video, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:video_id, :string)
      add(:video_url, :string)
      add(:video_path, :string)
      add(:thumbnail_url, :string)
      add(:thumbnail_path, :string)
      add(:publication_date, :integer)
      add(:publication_date_human, :string)
      add(:title, :string)
      add(:view_count, :integer)
      add(:description, :string)
      add(:channel, :string)
      add(:status, :video_status)
      add(:keep, :boolean)

      add(:playlist_id, references(:playlist, on_delete: :nothing, type: :binary_id))
      add(:channel_id, references(:channel, on_delete: :nothing, type: :binary_id))

      timestamps(type: :utc_datetime)
    end

    create(unique_index(:video, [:video_id]))
  end
end
