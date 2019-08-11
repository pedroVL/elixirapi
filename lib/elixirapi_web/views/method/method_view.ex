defmodule ElixirapiWeb.MethodView do
  use ElixirapiWeb, :view
  alias ElixirapiWeb.MethodView

  def render("index.json", %{methods: methods}) do
    %{data: render_many(methods, MethodView, "method.json")}
  end

  def render("show.json", %{method: method}) do
    %{data: render_one(method, MethodView, "method.json")}
  end

  def render("method.json", %{method: method}) do
    %{id: method.id,
      function: method.function,
      method: method.method}
  end
end
