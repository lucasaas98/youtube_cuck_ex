defmodule YoutubeCuck.Cuck.Response do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :id, autogenerate: true}
  schema "response" do
    field(:content, :map, default: %{})

    timestamps()
  end

  @doc false
  def changeset(response, attrs) do
    response
    |> cast(attrs, [
      :content
    ])
    |> validate_required([:content])
  end
end
