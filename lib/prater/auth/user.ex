defmodule Prater.Auth.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Prater.Auth.User


  schema "users" do
    field :email, :string
    field :encrypted_password, :string
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :username, :encrypted_password])
    |> validate_required([:email, :username, :encrypted_password])
    |> unique_constraint(:email)
    |> unique_constraint(:username)
  end
end
