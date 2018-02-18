defmodule Prater.Auth do
  alias Prater.Repo
  alias Prater.Auth.User

  def sign_in(email, password) do
    user = Repo.get_by(User, email: email)

    cond do
      user && user.encrypted_password == password ->
        {:ok, user}
      true ->
        {:error, :unauthorized}
    end
  end
end
