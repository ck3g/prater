defmodule Prater.AuthHelpers do
  @default_email "user@example.com"
  @default_password "password"

  def create_user(email \\ @default_email) do
    [username, _] = String.split(email, "@")
    params = %{
      email: email,
      username: username,
      password: @default_password,
      password_confirmation: @default_password
    }
    {:ok, user} = Prater.Auth.register(params)

    user
  end
end
