defmodule Prater.Conversation do
  alias Prater.Repo
  alias Prater.Conversation.Room

  def list_rooms do
    Repo.all(Room)
  end
end
