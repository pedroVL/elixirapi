defmodule ElixirapiWeb.Router do
  use ElixirapiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ElixirapiWeb do
    pipe_through :api
  end
end
