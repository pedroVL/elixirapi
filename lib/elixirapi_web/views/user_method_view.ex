defmodule ElixirapiWeb.UserMethodView do
  use ElixirapiWeb, :view
  alias ElixirapiWeb.UserMethodView

  def render("index.json", %{user_methods: user_methods}) do
    %{data: render_many(user_methods, UserMethodView, "user_method.json")}
  end

  def render("show.json", %{user_method: user_method}) do
    %{data: render_one(user_method, UserMethodView, "user_method.json")}
  end

  def render("user_method.json", %{user_method: user_method}) do
    %{id: user_method.id, user_id: user_method.user_id, method_id: user_method.method_id,
    user: Ecto.Adapters.SQL.query!( Elixirapi.Repo, "SELECT username  FROM users where id = "<> to_string(user_method.user_id)).rows,
    method: Ecto.Adapters.SQL.query!( Elixirapi.Repo, "SELECT function, method  FROM methods where id = "<> to_string(user_method.method_id)).rows
  }
  end
end
