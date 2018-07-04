defmodule GexbotWeb.AuthorizationController do
  use GexbotWeb, :controller

  alias Gexbot.Auth
  alias Gexbot.Auth.Authorization

  action_fallback GexbotWeb.FallbackController

  def index(conn, _params) do
    authorizations = Auth.list_authorizations()
    render(conn, "index.json", authorizations: authorizations)
  end

  def create(conn, %{"authorization" => authorization_params}) do
    with {:ok, %Authorization{} = authorization} <- Auth.create_authorization(authorization_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", authorization_path(conn, :show, authorization))
      |> render("show.json", authorization: authorization)
    end
  end

  def show(conn, %{"id" => id}) do
    authorization = Auth.get_authorization!(id)
    render(conn, "show.json", authorization: authorization)
  end

  def update(conn, %{"id" => id, "authorization" => authorization_params}) do
    authorization = Auth.get_authorization!(id)

    with {:ok, %Authorization{} = authorization} <- Auth.update_authorization(authorization, authorization_params) do
      render(conn, "show.json", authorization: authorization)
    end
  end

  def delete(conn, %{"id" => id}) do
    authorization = Auth.get_authorization!(id)
    with {:ok, %Authorization{}} <- Auth.delete_authorization(authorization) do
      send_resp(conn, :no_content, "")
    end
  end
end
