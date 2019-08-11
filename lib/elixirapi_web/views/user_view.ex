defmodule ElixirapiWeb.UserView do
  use ElixirapiWeb, :view
  alias ElixirapiWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end
  
  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end
  
  def render("user.json", %{user: user}) do
    %{id: user.id,
    username: user.username
    }
  end
  
  def render("sign_in.json", %{user: user}) do
    %{
      data: %{
        user: %{
          id: user.id,
          username: user.username
        }
      }
    }
  end
end
