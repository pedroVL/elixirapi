# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Elixirapi.Repo.insert!(%Elixirapi.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
Elixirapi.Auth.create_user(%{username: "test", password: "test"})
Elixirapi.Auth.create_user(%{username: "test2", password: "test"})
Elixirapi.Auth.create_user(%{username: "test3", password: "test"})
Elixirapi.Auth.create_user(%{username: "test4", password: "test"})
Elixirapi.Auth.create_user(%{username: "test5", password: "test"})


Elixirapi.Auth.create_book(%{name: "book1", description: "great book"})
Elixirapi.Auth.create_book(%{name: "book2", description: "amazing"})
Elixirapi.Auth.create_book(%{name: "book3", description: "aweful"})
Elixirapi.Auth.create_book(%{name: "book4", description: "inspiring"})
Elixirapi.Auth.create_book(%{name: "book5", description: "magical"})
Elixirapi.Auth.create_book(%{name: "book6", description: "scary"})
Elixirapi.Auth.create_book(%{name: "book7", description: "weak"})

Elixirapi.Auth.create_author(%{firsname: "author1", lastname: "ln1"})
Elixirapi.Auth.create_author(%{firsname: "author2", lastname: "ln2"})
Elixirapi.Auth.create_author(%{firsname: "author3", lastname: "ln3"})
Elixirapi.Auth.create_author(%{firsname: "author4", lastname: "ln4"})
Elixirapi.Auth.create_author(%{firsname: "author5", lastname: "ln5"})

Elixirapi.Auth.create_book_author(%{book_id: 1, author_id: 1})
Elixirapi.Auth.create_book_author(%{book_id: 2, author_id: 2})
Elixirapi.Auth.create_book_author(%{book_id: 2, author_id: 3})
Elixirapi.Auth.create_book_author(%{book_id: 3, author_id: 3})
Elixirapi.Auth.create_book_author(%{book_id: 4, author_id: 4})
Elixirapi.Auth.create_book_author(%{book_id: 5, author_id: 5})
Elixirapi.Auth.create_book_author(%{book_id: 6, author_id: 6})
Elixirapi.Auth.create_book_author(%{book_id: 7, author_id: 7})


Elixirapi.Auth.create_method(%{function: "function1", method: "method1"})
Elixirapi.Auth.create_method(%{function: "function2", method: "method2"})
Elixirapi.Auth.create_method(%{function: "function3", method: "method3"})
Elixirapi.Auth.create_method(%{function: "function4", method: "method4"})
Elixirapi.Auth.create_method(%{function: "function5", method: "method5"})
Elixirapi.Auth.create_method(%{function: "function6", method: "method6"})
Elixirapi.Auth.create_method(%{function: "function7", method: "method7"})

Elixirapi.Auth.create_user_method(%{user_id: 1, method_id: 1});
Elixirapi.Auth.create_user_method(%{user_id: 2, method_id: 2});
Elixirapi.Auth.create_user_method(%{user_id: 2, method_id: 3});
Elixirapi.Auth.create_user_method(%{user_id: 3, method_id: 3});
Elixirapi.Auth.create_user_method(%{user_id: 4, method_id: 4});
Elixirapi.Auth.create_user_method(%{user_id: 5, method_id: 5});
Elixirapi.Auth.create_user_method(%{user_id: 6, method_id: 5});