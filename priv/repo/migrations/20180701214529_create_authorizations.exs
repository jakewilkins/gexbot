defmodule Gexbot.Repo.Migrations.CreateAuthorizations do
  use Ecto.Migration

  def change do
    create table(:authorizations) do

      timestamps()
    end

  end
end
