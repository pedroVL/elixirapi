defmodule ElixirapiWeb.MethodController do
  use ElixirapiWeb, :controller

  alias Elixirapi.Auth
  alias Elixirapi.Auth.Method

  action_fallback ElixirapiWeb.FallbackController

  def index(conn, _params) do
    methods = Auth.list_methods()
    render(conn, "index.json", methods: methods)
  end

  def create(conn, %{"method" => method_params}) do
    with {:ok, %Method{} = method} <- Auth.create_method(method_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", method_path(conn, :show, method))
      |> render("show.json", method: method)
    end
  end

  def show(conn, %{"id" => id}) do
    method = Auth.get_method!(id)
    render(conn, "show.json", method: method)
  end

  def update(conn, %{"id" => id, "method" => method_params}) do
    method = Auth.get_method!(id)

    with {:ok, %Method{} = method} <- Auth.update_method(method, method_params) do
      render(conn, "show.json", method: method)
    end
  end

  def delete(conn, %{"id" => id}) do
    method = Auth.get_method!(id)
    with {:ok, %Method{}} <- Auth.delete_method(method) do
      send_resp(conn, :no_content, "")
    end
  end
end
