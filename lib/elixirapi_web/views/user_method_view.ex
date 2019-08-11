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
    %{id: user_method.id}
  end
end
