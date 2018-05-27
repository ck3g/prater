defmodule Prater.Auth do
  alias Prater.Repo
  alias Prater.Auth.User

  def sign_in(email, password) do
    user = Repo.get_by(User, email: email)

    if user && Comeonin.Bcrypt.checkpw(password, user.encrypted_password) do
      {:ok, user}
    else
      {:error, :unauthorized}
    end
  end

  def sign_out(conn) do
    Plug.Conn.configure_session(conn, drop: true)
  end

  def register(params) do
    %User{}
    |> User.registration_changeset(params)
    |> Repo.insert()
  end
end
