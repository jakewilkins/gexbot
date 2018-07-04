defmodule GexbotWeb.InstallationControllerTest do
  use GexbotWeb.ConnCase

  alias Gexbot.Auth
  alias Gexbot.Auth.Installation

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:installation) do
    {:ok, installation} = Auth.create_installation(@create_attrs)
    installation
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all installations", %{conn: conn} do
      conn = get conn, installation_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create installation" do
    test "renders installation when data is valid", %{conn: conn} do
      conn = post conn, installation_path(conn, :create), installation: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, installation_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, installation_path(conn, :create), installation: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update installation" do
    setup [:create_installation]

    test "renders installation when data is valid", %{conn: conn, installation: %Installation{id: id} = installation} do
      conn = put conn, installation_path(conn, :update, installation), installation: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, installation_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id}
    end

    test "renders errors when data is invalid", %{conn: conn, installation: installation} do
      conn = put conn, installation_path(conn, :update, installation), installation: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete installation" do
    setup [:create_installation]

    test "deletes chosen installation", %{conn: conn, installation: installation} do
      conn = delete conn, installation_path(conn, :delete, installation)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, installation_path(conn, :show, installation)
      end
    end
  end

  defp create_installation(_) do
    installation = fixture(:installation)
    {:ok, installation: installation}
  end
end
