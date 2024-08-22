defmodule YoutubeCuck.Repo.Migrations.CreateThumbnailFile do
  use Ecto.Migration

  def change do
    create table(:thumbnail_file, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :thumbnail_path, :string
      add :video_id, references(:video, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:thumbnail_file, [:video_id])
  end
end
