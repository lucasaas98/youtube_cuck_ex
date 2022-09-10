defmodule YoutubeCuck.Repo.Migrations.AddVideoTable do
  use Ecto.Migration
  alias YoutubeCuck.Cuck.VideoStatus

  def change do
    VideoStatus.create_type()

    create table(:video, primary_key: false) do
      add(:id, :id, primary_key: true)
      add(:video_url, :string)
      add(:video_path, :string)
      add(:thumbnail_url, :string)
      add(:thumbnail_path, :string)
      add(:publication_date, :integer)
      add(:publication_date_human, :string)
      add(:rating, :float)
      add(:title, :string)
      add(:view_count, :integer)
      add(:description, :string)
      add(:channel, :string)
      add(:status, :video_status)

      timestamps()
    end
  end
end
