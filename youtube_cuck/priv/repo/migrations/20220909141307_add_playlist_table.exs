defmodule YoutubeCuck.Repo.Migrations.AddPlaylistTable do
  use Ecto.Migration

  def change do
    create table(:playlist, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:name, :string)

      timestamps(type: :utc_datetime)
    end

    create(unique_index(:playlist, [:name]))
  end
end
