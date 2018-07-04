defmodule Gexbot.Repo.Migrations.CreatePeople do
  use Ecto.Migration

  def change do
    create table(:people) do

      timestamps()
    end

  end
end
