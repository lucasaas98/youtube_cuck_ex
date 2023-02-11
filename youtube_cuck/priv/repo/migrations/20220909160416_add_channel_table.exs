defmodule YoutubeCuck.Repo.Migrations.AddChannelTable do
  use Ecto.Migration

  def change do
    create table(:channel, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:name, :string)
      add(:rss_url, :string)
      add(:channel_url, :string)
      add(:subscribed, :boolean, default: false)
      add(:last_fetch, :utc_datetime)

      timestamps(type: :utc_datetime)
    end

    create(unique_index(:channel, [:id]))
  end
end
