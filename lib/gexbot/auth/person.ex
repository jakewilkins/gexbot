defmodule Gexbot.Auth.Person do
  use Ecto.Schema
  import Ecto.Changeset
  alias Gexbot.Auth.Person


  schema "people" do

    timestamps()
  end

  @doc false
  def changeset(%Person{} = person, attrs) do
    person
    |> cast(attrs, [])
    |> validate_required([])
  end
end
