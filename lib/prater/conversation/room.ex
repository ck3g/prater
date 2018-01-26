defmodule Prater.Conversation.Room do
  use Ecto.Schema
  import Ecto.Changeset
  alias Prater.Conversation.Room


  schema "rooms" do
    field :description, :string
    field :name, :string
    field :topic, :string

    timestamps()
  end

  @doc false
  def changeset(%Room{} = room, attrs) do
    room
    |> cast(attrs, [:name, :description, :topic])
    |> validate_required([:name])
    |> unique_constraint(:name)
    |> validate_length(:name, min: 3, max: 25)
    |> validate_length(:topic, min: 5, max: 100)
  end
end
