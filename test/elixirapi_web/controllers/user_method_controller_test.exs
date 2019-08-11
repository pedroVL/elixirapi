defmodule ElixirapiWeb.UserMethodControllerTest do
  use ElixirapiWeb.ConnCase

  alias Elixirapi.Auth
  alias Elixirapi.Auth.UserMethod

  @create_attrs %{user_id: 1, method_id: 2}
  @update_attrs %{user_id: 2, method_id: 3}
  @invalid_attrs %{user_id: nil, method_id: nil}

  def fixture(:user_method) do
    {:ok, user_method} = Auth.create_user_method(@create_attrs)
    user_method
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all user_methods", %{conn: conn} do
      conn = get conn, user_method_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create user_method" do
    test "renders user_method when data is valid", %{conn: conn} do
      conn = post conn, user_method_path(conn, :create), user_method: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, user_method_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, user_method_path(conn, :create), user_method: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update user_method" do
    setup [:create_user_method]

    test "renders user_method when data is valid", %{conn: conn, user_method: %UserMethod{id: id} = user_method} do
      conn = put conn, user_method_path(conn, :update, user_method), user_method: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, user_method_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id}
    end

    test "renders errors when data is invalid", %{conn: conn, user_method: user_method} do
      conn = put conn, user_method_path(conn, :update, user_method), user_method: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete user_method" do
    setup [:create_user_method]

    test "deletes chosen user_method", %{conn: conn, user_method: user_method} do
      conn = delete conn, user_method_path(conn, :delete, user_method)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, user_method_path(conn, :show, user_method)
      end
    end
  end

  defp create_user_method(_) do
    user_method = fixture(:user_method)
    {:ok, user_method: user_method}
  end
end
