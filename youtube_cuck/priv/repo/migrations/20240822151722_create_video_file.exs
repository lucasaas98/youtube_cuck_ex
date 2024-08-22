defmodule YoutubeCuck.Repo.Migrations.CreateVideoFile do
  use Ecto.Migration

  def change do
    create table(:video_file, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :video_path, :string
      add :video_id, references(:video, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:video_file, [:video_id])
  end
end
