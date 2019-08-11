defmodule Elixirapi.AuthTest do
  use Elixirapi.DataCase

  alias Elixirapi.Auth
  alias Elixirapi.Auth.User

  describe "users" do

    @valid_attrs %{username: "some username", password: "some password"}
    @update_attrs %{
      username: "some updated username",
      password: "some updated password"
    }
    @invalid_attrs %{username: nil, password: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Auth.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Auth.list_users() == [%User{user | password: nil}]

    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Auth.get_user!(user.id) == %User{user | password: nil}
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Auth.create_user(@valid_attrs)
      assert user.username == "some username"
      assert user.password == "some password"
      assert Bcrypt.verify_pass("some password", user.password_hash)

    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Auth.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, user} = Auth.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.username == "some updated username"
      assert Bcrypt.verify_pass("some updated password", user.password_hash)

    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Auth.update_user(user, @invalid_attrs)
      assert %User{user | password: nil} == Auth.get_user!(user.id)
      assert Bcrypt.verify_pass("some password", user.password_hash)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Auth.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Auth.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Auth.change_user(user)
    end
  end

  test "authenticate_user/2 authenticates the user" do
    user = user_fixture()
    assert {:error, "Wrong username or password"} = Auth.authenticate_user("wrong username", "")
    assert {:ok, authenticated_user} = Auth.authenticate_user(user.username, @valid_attrs.password)
  end

  describe "book" do
    alias Elixirapi.Auth.Book

    @valid_attrs %{description: "some description", name: "some name"}
    @update_attrs %{description: "some updated description", name: "some updated name"}
    @invalid_attrs %{description: nil, name: nil}

    def book_fixture(attrs \\ %{}) do
      {:ok, book} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Auth.create_book()

      book
    end

    test "list_books/0 returns all book" do
      book = book_fixture()
      assert Auth.list_books() == [book]
    end

    test "get_book!/1 returns the book with given id" do
      book = book_fixture()
      assert Auth.get_book!(book.id) == book
    end

    test "create_book/1 with valid data creates a book" do
      assert {:ok, %Book{} = book} = Auth.create_book(@valid_attrs)
      assert book.description == "some description"
      assert book.name == "some name"
    end

    test "create_book/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Auth.create_book(@invalid_attrs)
    end

    test "update_book/2 with valid data updates the book" do
      book = book_fixture()
      assert {:ok, book} = Auth.update_book(book, @update_attrs)
      assert %Book{} = book
      assert book.description == "some updated description"
      assert book.name == "some updated name"
    end

    test "update_book/2 with invalid data returns error changeset" do
      book = book_fixture()
      assert {:error, %Ecto.Changeset{}} = Auth.update_book(book, @invalid_attrs)
      assert book == Auth.get_book!(book.id)
    end

    test "delete_book/1 deletes the book" do
      book = book_fixture()
      assert {:ok, %Book{}} = Auth.delete_book(book)
      assert_raise Ecto.NoResultsError, fn -> Auth.get_book!(book.id) end
    end

    test "change_book/1 returns a book changeset" do
      book = book_fixture()
      assert %Ecto.Changeset{} = Auth.change_book(book)
    end
  end

  describe "authors" do
    alias Elixirapi.Auth.Author

    @valid_attrs %{firstname: "some firstname", lastname: "some lastname"}
    @update_attrs %{firstname: "some updated firstname", lastname: "some updated lastname"}
    @invalid_attrs %{firstname: nil, lastname: nil}

    def author_fixture(attrs \\ %{}) do
      {:ok, author} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Auth.create_author()

      author
    end

    test "list_authors/0 returns all authors" do
      author = author_fixture()
      assert Auth.list_authors() == [author]
    end

    test "get_author!/1 returns the author with given id" do
      author = author_fixture()
      assert Auth.get_author!(author.id) == author
    end

    test "create_author/1 with valid data creates a author" do
      assert {:ok, %Author{} = author} = Auth.create_author(@valid_attrs)
      assert author.firstname == "some firstname"
      assert author.lastname == "some lastname"
    end

    test "create_author/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Auth.create_author(@invalid_attrs)
    end

    test "update_author/2 with valid data updates the author" do
      author = author_fixture()
      assert {:ok, author} = Auth.update_author(author, @update_attrs)
      assert %Author{} = author
      assert author.firstname == "some updated firstname"
      assert author.lastname == "some updated lastname"
    end

    test "update_author/2 with invalid data returns error changeset" do
      author = author_fixture()
      assert {:error, %Ecto.Changeset{}} = Auth.update_author(author, @invalid_attrs)
      assert author == Auth.get_author!(author.id)
    end

    test "delete_author/1 deletes the author" do
      author = author_fixture()
      assert {:ok, %Author{}} = Auth.delete_author(author)
      assert_raise Ecto.NoResultsError, fn -> Auth.get_author!(author.id) end
    end

    test "change_author/1 returns a author changeset" do
      author = author_fixture()
      assert %Ecto.Changeset{} = Auth.change_author(author)
    end
  end

  describe "book_authors" do
    alias Elixirapi.Auth.BookAuthor

    @create_attrs %{book_id: 1, author_id: 2}
    @update_attrs %{book_id: 2, author_id: 3}
    @invalid_attrs %{book_id: nil, author_id: nil}

    def book_author_fixture(attrs \\ %{}) do
      {:ok, book_author} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Auth.create_book_author()

      book_author
    end

    test "list_book_authors/0 returns all book_authors" do
      book_author = book_author_fixture()
      assert Auth.list_book_authors() == [book_author]
    end

    test "get_book_author!/1 returns the book_author with given id" do
      book_author = book_author_fixture()
      assert Auth.get_book_author!(book_author.id) == book_author
    end

    test "create_book_author/1 with valid data creates a book_author" do
      assert {:ok, %BookAuthor{} = book_author} = Auth.create_book_author(@valid_attrs)
    end

    test "create_book_author/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Auth.create_book_author(@invalid_attrs)
    end

    test "update_book_author/2 with valid data updates the book_author" do
      book_author = book_author_fixture()
      assert {:ok, book_author} = Auth.update_book_author(book_author, @update_attrs)
      assert %BookAuthor{} = book_author
    end

    test "update_book_author/2 with invalid data returns error changeset" do
      book_author = book_author_fixture()
      assert {:error, %Ecto.Changeset{}} = Auth.update_book_author(book_author, @invalid_attrs)
      assert book_author == Auth.get_book_author!(book_author.id)
    end

    test "delete_book_author/1 deletes the book_author" do
      book_author = book_author_fixture()
      assert {:ok, %BookAuthor{}} = Auth.delete_book_author(book_author)
      assert_raise Ecto.NoResultsError, fn -> Auth.get_book_author!(book_author.id) end
    end

    test "change_book_author/1 returns a book_author changeset" do
      book_author = book_author_fixture()
      assert %Ecto.Changeset{} = Auth.change_book_author(book_author)
    end
  end

  describe "methods" do
    alias Elixirapi.Auth.Method

    @valid_attrs %{function: "some function", method: "some method"}
    @update_attrs %{function: "some updated function", method: "some updated method"}
    @invalid_attrs %{function: nil, method: nil}

    def method_fixture(attrs \\ %{}) do
      {:ok, method} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Auth.create_method()

      method
    end

    test "list_methods/0 returns all methods" do
      method = method_fixture()
      assert Auth.list_methods() == [method]
    end

    test "get_method!/1 returns the method with given id" do
      method = method_fixture()
      assert Auth.get_method!(method.id) == method
    end

    test "create_method/1 with valid data creates a method" do
      assert {:ok, %Method{} = method} = Auth.create_method(@valid_attrs)
      assert method.function == "some function"
      assert method.method == "some method"
    end

    test "create_method/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Auth.create_method(@invalid_attrs)
    end

    test "update_method/2 with valid data updates the method" do
      method = method_fixture()
      assert {:ok, method} = Auth.update_method(method, @update_attrs)
      assert %Method{} = method
      assert method.function == "some updated function"
      assert method.method == "some updated method"
    end

    test "update_method/2 with invalid data returns error changeset" do
      method = method_fixture()
      assert {:error, %Ecto.Changeset{}} = Auth.update_method(method, @invalid_attrs)
      assert method == Auth.get_method!(method.id)
    end

    test "delete_method/1 deletes the method" do
      method = method_fixture()
      assert {:ok, %Method{}} = Auth.delete_method(method)
      assert_raise Ecto.NoResultsError, fn -> Auth.get_method!(method.id) end
    end

    test "change_method/1 returns a method changeset" do
      method = method_fixture()
      assert %Ecto.Changeset{} = Auth.change_method(method)
    end
  end
end
