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

    test "list_book/0 returns all book" do
      book = book_fixture()
      assert Auth.list_book() == [book]
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
end
