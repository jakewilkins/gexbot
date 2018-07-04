defmodule Gexbot.Repo.Migrations.CreateInstallations do
  use Ecto.Migration

  def change do
    create table(:installations) do
      add :installation_id, :string
      add :username, :string
      add :installed_by, :string
      add :permissions, :map
      add :events, {:array, :string}
      timestamps()
    end

    create index(:installations, [:installation_id])
    create index(:installations, [:username])
  end
end
