defmodule PraterWeb.RoomChannel do
  use PraterWeb, :channel

  alias Prater.Repo
  alias Prater.Auth.User
  alias Prater.Conversation
  alias PraterWeb.Presence

  def join("room:" <> room_id, _params, socket) do
    send(self(), :after_join)

    {
      :ok,
      %{messages: Conversation.list_messages(room_id)},
      assign(socket, :room_id, room_id)
    }
  end

  def handle_in("message:add", %{"message" => content}, socket) do
    room = Conversation.get_room!(socket.assigns[:room_id])
    user = find_user(socket)

    case Conversation.create_message(user, room, %{content: content}) do
      {:ok, message} ->
        message = Repo.preload(message, :user)
        message_template = %{content: message.content, user: %{username: message.user.username}}
        broadcast!(socket, "room:#{message.room_id}:new_message", message_template)
        {:reply, :ok, socket}

      {:error, _reason} ->
        {:reply, :error, socket}
    end
  end

  def handle_in("user:typing", %{"typing" => typing}, socket) do
    user = find_user(socket)

    {:ok, _} = Presence.update(socket, "user:#{user.id}", %{
      typing: typing,
      user_id: user.id,
      username: user.username
    })

    {:reply, :ok, socket}
  end

  def handle_info(:after_join, socket) do
    push socket, "presence_state", Presence.list(socket)

    user = find_user(socket)

    {:ok, _} = Presence.track(socket, "user:#{user.id}", %{
      typing: false,
      user_id: user.id,
      username: user.username
    })

    {:noreply, socket}
  end

  defp find_user(socket) do
    Repo.get(User, socket.assigns[:current_user_id])
  end
end
