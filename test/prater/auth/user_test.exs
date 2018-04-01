defmodule Prater.Auth.UserTest do
  use Prater.DataCase, async: true

  alias Prater.Auth.User

  describe "User.registration_changeset/2" do
    @valid_attrs %{
      email: "user@example.com",
      username: "user",
      password: "password",
      password_confirmation: "password"
    }
    @invalid_attrs %{}

    test "changeset with valid attributes" do
      changeset = User.registration_changeset(%User{}, @valid_attrs)

      assert changeset.valid?
    end

    test "changeset with invalid attributes" do
      changeset = User.registration_changeset(%User{}, @invalid_attrs)

      refute changeset.valid?
    end

    test "changest with username less than 3 characters" do
      changeset = User.registration_changeset(%User{}, %{@valid_attrs | username: "uu"})

      assert %{username: ["should be at least 3 character(s)"]} = errors_on(changeset)
    end

    test "changest with username more than 30 characters" do
      attrs = %{@valid_attrs | username: String.duplicate("u", 31)}
      changeset = User.registration_changeset(%User{}, attrs)

      assert %{username: ["should be at most 30 character(s)"]} = errors_on(changeset)
    end
  end
end
