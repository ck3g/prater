defmodule Prater.AuthTest do
  use Prater.DataCase, async: true

  alias Prater.Repo
  alias Prater.Auth
  alias Prater.Auth.User

  describe "Auth.register/1" do
    @valid_attrs %{
      email: "user@example.com",
      username: "user",
      password: "password",
      password_confirmation: "password"
    }

    test "changeset with non-unique email" do
      Auth.register(@valid_attrs)

      {:error, changeset} = Auth.register(@valid_attrs)

      assert %{email: ["has already been taken"]} = errors_on(changeset)
    end

    test "all attributes are saved properly" do
      {:ok, user} = Auth.register(@valid_attrs)
      user = Repo.get!(User, user.id)

      assert is_nil(user.password)
      assert Comeonin.Bcrypt.checkpw(@valid_attrs[:password], user.encrypted_password)
      assert user.email == @valid_attrs[:email]
      assert user.username == @valid_attrs[:username]
    end
  end
end
