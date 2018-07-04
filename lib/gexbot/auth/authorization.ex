defmodule Gexbot.Auth.Authorization do
  use Ecto.Schema
  import Ecto.Changeset
  alias Gexbot.Auth.Authorization


  schema "authorizations" do

    timestamps()
  end

  @doc false
  def changeset(%Authorization{} = authorization, attrs) do
    authorization
    |> cast(attrs, [])
    |> validate_required([])
  end
end
