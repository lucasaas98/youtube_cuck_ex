defmodule YoutubeCuck.Repo.Migrations.CreateVideo do
  use Ecto.Migration

  def change do
    create table(:video, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string
      add :url, :string
      add :views, :integer
      add :description, :string
      add :status, :string
      add :channel_id, references(:channel, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create unique_index(:video, [:url])
    create index(:video, [:channel_id])
  end
end
