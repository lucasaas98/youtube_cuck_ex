defmodule YoutubeCuck.Repo.Migrations.AddResponseTable do
  use Ecto.Migration

  def change do
    create table(:response, primary_key: false) do
      add(:id, :id, primary_key: true)
      add(:content, :map, default: "{}")

      timestamps()
    end
  end
end
