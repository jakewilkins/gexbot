defmodule Gexbot.Auth.Installation do
  use Ecto.Schema
  import Ecto.Changeset
  alias Gexbot.Auth.Installation

  @attributes [
    :installation_id,
    :username,
    :installed_by,
    :permissions,
    :events
  ]


  schema "installations" do
    field :installation_id, :string
    field :username, :string
    field :installed_by, :string
    field :permissions, :map
    field :events, {:array, :string}
    timestamps()
  end

  @doc false
  def changeset(%Installation{} = installation, attrs) do
    installation
    |> cast(attrs, @attributes)
    # |> validate_required(@attributes)
  end
end
