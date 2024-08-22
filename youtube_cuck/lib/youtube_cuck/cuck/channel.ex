defmodule YoutubeCuck.Cuck.Channel do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "channel" do
    field(:title, :string)
    field(:external_id, :string)
    field(:subscriber_count, :integer)
    has_many(:videos, YoutubeCuck.Cuck.Video)

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(channel, attrs) do
    channel
    |> cast(attrs, [:title, :external_id, :subscriber_count])
    |> validate_required([:title, :external_id])
  end
end
