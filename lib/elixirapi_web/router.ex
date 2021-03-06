defmodule ElixirapiWeb.Router do
  use ElixirapiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
  end

  pipeline :api_auth do
    plug :ensure_authenticated
  end

  scope "/api", ElixirapiWeb do
    pipe_through :api
    resources "/users", UserController, only: [:index, :show]
    resources "/books", BookController, only: [:index, :show]
    resources "/authors", AuthorController, only: [:index, :show]
    resources "/book_authors", BookAuthorController, only: [:index, :show]
    resources "/user_methods", UserMethodController, only: [:index, :show]
    post "/users/sign_in", UserController, :sign_in
    #for testing only
    resources "/users", UserController, except: [:new, :edit, :index, :show]
    resources "/books", BookController, except: [:new, :edit, :index, :show]
    resources "/authors", AuthorController, except: [:new, :edit, :index, :show]
    resources "/book_authors", BookAuthorController, except: [:new, :edit, :index, :show]
    resources "/user_methods", UserMethodController, except: [:new, :edit, :index, :show]
    resources "/methods", MethodController, except: [:new, :edit, :index, :show]
  end
  
  scope "/api", ElixirapiWeb do
    pipe_through [:api, :api_auth]
    # resources "/users", UserController, except: [:new, :edit, :index, :show]
    # resources "/books", BookController, except: [:new, :edit, :index, :show]
    # resources "/authors", AuthorController, except: [:new, :edit, :index, :show]
    # resources "/book_authors", BookAuthorController, except: [:new, :edit, :index, :show]
    # resources "/methods", MethodController, except: [:new, :edit, :index, :show]
  end

  # Plug function
  defp ensure_authenticated(conn, _opts) do
    current_user_id = get_session(conn, :current_user_id)

    if current_user_id do
      conn
    else
      conn
      |> put_status(:unauthorized)
      |> put_view(ElixirapiWeb.ErrorView)
      |> render("401.json", message: "Unauthenticated user")
      |> halt()
    end
  end

end
