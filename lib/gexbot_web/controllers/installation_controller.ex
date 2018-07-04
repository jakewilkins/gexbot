defmodule GexbotWeb.InstallationController do
  use GexbotWeb, :controller

  alias Gexbot.Auth
  alias Gexbot.Auth.Installation

  action_fallback GexbotWeb.FallbackController

  def index(conn, _params) do
    installations = Auth.list_installations()
    render(conn, "index.json", installations: installations)
  end

  def create(conn, %{"installation" => installation_params}) do
    with {:ok, %Installation{} = installation} <- Auth.create_installation(installation_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", installation_path(conn, :show, installation))
      |> render("show.json", installation: installation)
    end
  end

  def show(conn, %{"id" => id}) do
    installation = Auth.get_installation!(id)
    render(conn, "show.json", installation: installation)
  end

  def update(conn, %{"id" => id, "installation" => installation_params}) do
    installation = Auth.get_installation!(id)

    with {:ok, %Installation{} = installation} <- Auth.update_installation(installation, installation_params) do
      render(conn, "show.json", installation: installation)
    end
  end

  def delete(conn, %{"id" => id}) do
    installation = Auth.get_installation!(id)
    with {:ok, %Installation{}} <- Auth.delete_installation(installation) do
      send_resp(conn, :no_content, "")
    end
  end
end
