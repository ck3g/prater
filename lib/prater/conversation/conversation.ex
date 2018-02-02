defmodule Prater.Conversation do
  alias Prater.Repo
  alias Prater.Conversation.Room

  def list_rooms do
    Repo.all(Room)
  end

  def create_room(attrs \\ %{}) do
    %Room{}
    |> Room.changeset(attrs)
    |> Repo.insert()
  end

  def change_room(%Room{} = room) do
    Room.changeset(room, %{})
  end
end
