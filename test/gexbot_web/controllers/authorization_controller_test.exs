defmodule GexbotWeb.AuthorizationControllerTest do
  use GexbotWeb.ConnCase

  alias Gexbot.Auth
  alias Gexbot.Auth.Authorization

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:authorization) do
    {:ok, authorization} = Auth.create_authorization(@create_attrs)
    authorization
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all authorizations", %{conn: conn} do
      conn = get conn, authorization_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create authorization" do
    test "renders authorization when data is valid", %{conn: conn} do
      conn = post conn, authorization_path(conn, :create), authorization: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, authorization_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, authorization_path(conn, :create), authorization: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update authorization" do
    setup [:create_authorization]

    test "renders authorization when data is valid", %{conn: conn, authorization: %Authorization{id: id} = authorization} do
      conn = put conn, authorization_path(conn, :update, authorization), authorization: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, authorization_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id}
    end

    test "renders errors when data is invalid", %{conn: conn, authorization: authorization} do
      conn = put conn, authorization_path(conn, :update, authorization), authorization: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete authorization" do
    setup [:create_authorization]

    test "deletes chosen authorization", %{conn: conn, authorization: authorization} do
      conn = delete conn, authorization_path(conn, :delete, authorization)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, authorization_path(conn, :show, authorization)
      end
    end
  end

  defp create_authorization(_) do
    authorization = fixture(:authorization)
    {:ok, authorization: authorization}
  end
end
