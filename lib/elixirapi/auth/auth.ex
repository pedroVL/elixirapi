defmodule Elixirapi.Auth do
  @moduledoc """
  The Auth context.
  """

  import Ecto.Query, warn: false
  alias Elixirapi.Repo

  alias Elixirapi.Auth.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a User.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  def authenticate_user(username, password) do
    query = from(u in User, where: u.username == ^username)
    query |> Repo.one() |> verify_password(password)
  end
  
  defp verify_password(nil, _) do
    # Perform a dummy check to make user enumeration more difficult
    Bcrypt.no_user_verify()
    {:error, "Wrong username or password"}
  end

  defp verify_password(user, password) do
    if Bcrypt.verify_pass(password, user.password_hash) do
      {:ok, user}
    else
      {:error, "Wrong username or password"}
    end
  end

  alias Elixirapi.Auth.Book

  @doc """
  Returns the list of book.

  ## Examples

      iex> list_book()
      [%Book{}, ...]

  """
  def list_books do
    Repo.all(Book)
  end

  @doc """
  Gets a single book.

  Raises `Ecto.NoResultsError` if the Book does not exist.

  ## Examples

      iex> get_book!(123)
      %Book{}

      iex> get_book!(456)
      ** (Ecto.NoResultsError)

  """
  def get_book!(id), do: Repo.get!(Book, id)

  @doc """
  Creates a book.

  ## Examples

      iex> create_book(%{field: value})
      {:ok, %Book{}}

      iex> create_book(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_book(attrs \\ %{}) do
    %Book{}
    |> Book.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a book.

  ## Examples

      iex> update_book(book, %{field: new_value})
      {:ok, %Book{}}

      iex> update_book(book, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_book(%Book{} = book, attrs) do
    book
    |> Book.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Book.

  ## Examples

      iex> delete_book(book)
      {:ok, %Book{}}

      iex> delete_book(book)
      {:error, %Ecto.Changeset{}}

  """
  def delete_book(%Book{} = book) do
    Repo.delete(book)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking book changes.

  ## Examples

      iex> change_book(book)
      %Ecto.Changeset{source: %Book{}}

  """
  def change_book(%Book{} = book) do
    Book.changeset(book, %{})
  end

  alias Elixirapi.Auth.Author

  @doc """
  Returns the list of authors.

  ## Examples

      iex> list_authors()
      [%Author{}, ...]

  """
  def list_authors do
    Repo.all(Author)
  end

  @doc """
  Gets a single author.

  Raises `Ecto.NoResultsError` if the Author does not exist.

  ## Examples

      iex> get_author!(123)
      %Author{}

      iex> get_author!(456)
      ** (Ecto.NoResultsError)

  """
  def get_author!(id), do: Repo.get!(Author, id)

  @doc """
  Creates a author.

  ## Examples

      iex> create_author(%{field: value})
      {:ok, %Author{}}

      iex> create_author(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_author(attrs \\ %{}) do
    %Author{}
    |> Author.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a author.

  ## Examples

      iex> update_author(author, %{field: new_value})
      {:ok, %Author{}}

      iex> update_author(author, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_author(%Author{} = author, attrs) do
    author
    |> Author.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Author.

  ## Examples

      iex> delete_author(author)
      {:ok, %Author{}}

      iex> delete_author(author)
      {:error, %Ecto.Changeset{}}

  """
  def delete_author(%Author{} = author) do
    Repo.delete(author)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking author changes.

  ## Examples

      iex> change_author(author)
      %Ecto.Changeset{source: %Author{}}

  """
  def change_author(%Author{} = author) do
    Author.changeset(author, %{})
  end

  alias Elixirapi.Auth.BookAuthor

  @doc """
  Returns the list of book_authors.

  ## Examples

      iex> list_book_authors()
      [%BookAuthor{}, ...]

  """
  def list_book_authors do
    Repo.all(BookAuthor)
  end

  @doc """
  Gets a single book_author.

  Raises `Ecto.NoResultsError` if the Book author does not exist.

  ## Examples

      iex> get_book_author!(123)
      %BookAuthor{}

      iex> get_book_author!(456)
      ** (Ecto.NoResultsError)

  """
  def get_book_author!(id), do: Repo.get!(BookAuthor, id)

  @doc """
  Creates a book_author.

  ## Examples

      iex> create_book_author(%{field: value})
      {:ok, %BookAuthor{}}

      iex> create_book_author(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_book_author(attrs \\ %{}) do
    %BookAuthor{}
    |> BookAuthor.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a book_author.

  ## Examples

      iex> update_book_author(book_author, %{field: new_value})
      {:ok, %BookAuthor{}}

      iex> update_book_author(book_author, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_book_author(%BookAuthor{} = book_author, attrs) do
    book_author
    |> BookAuthor.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a BookAuthor.

  ## Examples

      iex> delete_book_author(book_author)
      {:ok, %BookAuthor{}}

      iex> delete_book_author(book_author)
      {:error, %Ecto.Changeset{}}

  """
  def delete_book_author(%BookAuthor{} = book_author) do
    Repo.delete(book_author)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking book_author changes.

  ## Examples

      iex> change_book_author(book_author)
      %Ecto.Changeset{source: %BookAuthor{}}

  """
  def change_book_author(%BookAuthor{} = book_author) do
    BookAuthor.changeset(book_author, %{})
  end

  alias Elixirapi.Auth.Method

  @doc """
  Returns the list of methods.

  ## Examples

      iex> list_methods()
      [%Method{}, ...]

  """
  def list_methods do
    Repo.all(Method)
  end

  @doc """
  Gets a single method.

  Raises `Ecto.NoResultsError` if the Method does not exist.

  ## Examples

      iex> get_method!(123)
      %Method{}

      iex> get_method!(456)
      ** (Ecto.NoResultsError)

  """
  def get_method!(id), do: Repo.get!(Method, id)

  @doc """
  Creates a method.

  ## Examples

      iex> create_method(%{field: value})
      {:ok, %Method{}}

      iex> create_method(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_method(attrs \\ %{}) do
    %Method{}
    |> Method.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a method.

  ## Examples

      iex> update_method(method, %{field: new_value})
      {:ok, %Method{}}

      iex> update_method(method, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_method(%Method{} = method, attrs) do
    method
    |> Method.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Method.

  ## Examples

      iex> delete_method(method)
      {:ok, %Method{}}

      iex> delete_method(method)
      {:error, %Ecto.Changeset{}}

  """
  def delete_method(%Method{} = method) do
    Repo.delete(method)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking method changes.

  ## Examples

      iex> change_method(method)
      %Ecto.Changeset{source: %Method{}}

  """
  def change_method(%Method{} = method) do
    Method.changeset(method, %{})
  end

  alias Elixirapi.Auth.UserMethod

  @doc """
  Returns the list of user_methods.

  ## Examples

      iex> list_user_methods()
      [%UserMethod{}, ...]

  """
  def list_user_methods do
    Repo.all(UserMethod)
  end

  @doc """
  Gets a single user_method.

  Raises `Ecto.NoResultsError` if the User method does not exist.

  ## Examples

      iex> get_user_method!(123)
      %UserMethod{}

      iex> get_user_method!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user_method!(id), do: Repo.get!(UserMethod, id)

  @doc """
  Creates a user_method.

  ## Examples

      iex> create_user_method(%{field: value})
      {:ok, %UserMethod{}}

      iex> create_user_method(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user_method(attrs \\ %{}) do
    %UserMethod{}
    |> UserMethod.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user_method.

  ## Examples

      iex> update_user_method(user_method, %{field: new_value})
      {:ok, %UserMethod{}}

      iex> update_user_method(user_method, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user_method(%UserMethod{} = user_method, attrs) do
    user_method
    |> UserMethod.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a UserMethod.

  ## Examples

      iex> delete_user_method(user_method)
      {:ok, %UserMethod{}}

      iex> delete_user_method(user_method)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user_method(%UserMethod{} = user_method) do
    Repo.delete(user_method)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user_method changes.

  ## Examples

      iex> change_user_method(user_method)
      %Ecto.Changeset{source: %UserMethod{}}

  """
  def change_user_method(%UserMethod{} = user_method) do
    UserMethod.changeset(user_method, %{})
  end
end
