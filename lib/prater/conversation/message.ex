defmodule Prater.Conversation.Message do
  use Ecto.Schema
  import Ecto.Changeset
  alias Prater.Conversation.Message


  schema "messages" do
    field :content, :string
    belongs_to :room, Prater.Conversation.Room
    belongs_to :user, Prater.Auth.User

    timestamps()
  end

  @doc false
  def changeset(%Message{} = message, attrs) do
    message
    |> cast(attrs, [:content])
    |> validate_required([:content, :room_id, :user_id])
  end
end
