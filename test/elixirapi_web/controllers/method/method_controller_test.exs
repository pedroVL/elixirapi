defmodule ElixirapiWeb.MethodControllerTest do
  use ElixirapiWeb.ConnCase

  alias Elixirapi.Auth
  alias Elixirapi.Auth.Method

  @create_attrs %{function: "some function", method: "some method"}
  @update_attrs %{function: "some updated function", method: "some updated method"}
  @invalid_attrs %{function: nil, method: nil}

  def fixture(:method) do
    {:ok, method} = Auth.create_method(@create_attrs)
    method
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all methods", %{conn: conn} do
      conn = get conn, method_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create method" do
    test "renders method when data is valid", %{conn: conn} do
      conn = post conn, method_path(conn, :create), method: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, method_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "function" => "some function",
        "method" => "some method"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, method_path(conn, :create), method: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update method" do
    setup [:create_method]

    test "renders method when data is valid", %{conn: conn, method: %Method{id: id} = method} do
      conn = put conn, method_path(conn, :update, method), method: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, method_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "function" => "some updated function",
        "method" => "some updated method"}
    end

    test "renders errors when data is invalid", %{conn: conn, method: method} do
      conn = put conn, method_path(conn, :update, method), method: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete method" do
    setup [:create_method]

    test "deletes chosen method", %{conn: conn, method: method} do
      conn = delete conn, method_path(conn, :delete, method)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, method_path(conn, :show, method)
      end
    end
  end

  defp create_method(_) do
    method = fixture(:method)
    {:ok, method: method}
  end
end
