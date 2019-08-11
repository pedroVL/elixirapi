defmodule ElixirapiWeb.UserMethodController do
  use ElixirapiWeb, :controller

  alias Elixirapi.Auth
  alias Elixirapi.Auth.UserMethod

  action_fallback ElixirapiWeb.FallbackController

  def index(conn, _params) do
    user_methods = Auth.list_user_methods()
    render(conn, "index.json", user_methods: user_methods)
  end

  def create(conn, %{"user_method" => user_method_params}) do
    with {:ok, %UserMethod{} = user_method} <- Auth.create_user_method(user_method_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", user_method_path(conn, :show, user_method))
      |> render("show.json", user_method: user_method)
    end
  end

  def show(conn, %{"id" => id}) do
    user_method = Auth.get_user_method!(id)
    render(conn, "show.json", user_method: user_method)
  end

  def update(conn, %{"id" => id, "user_method" => user_method_params}) do
    user_method = Auth.get_user_method!(id)

    with {:ok, %UserMethod{} = user_method} <- Auth.update_user_method(user_method, user_method_params) do
      render(conn, "show.json", user_method: user_method)
    end
  end

  def delete(conn, %{"id" => id}) do
    user_method = Auth.get_user_method!(id)
    with {:ok, %UserMethod{}} <- Auth.delete_user_method(user_method) do
      send_resp(conn, :no_content, "")
    end
  end
end
