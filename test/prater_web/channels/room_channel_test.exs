defmodule PraterWeb.RoomChannelTest do
  use PraterWeb.ChannelCase

  alias Prater.Conversation
  alias PraterWeb.UserSocket

  import Prater.AuthHelpers

  setup do
    user = create_user("user@example.com")
    {:ok, room} = Conversation.create_room(user, %{name: "Lobby"})

    token = Phoenix.Token.sign(@endpoint, "user token", user.id)
    {:ok, socket} = connect(UserSocket, %{"token" => token})

    {:ok, socket: socket, user: user, room: room}
  end

  test "assigns room_id to the socket after join", %{socket: socket, room: room} do
    {:ok, _, socket} = subscribe_and_join(socket, "room:#{room.id}", %{})

    assert socket.assigns.room_id == "#{room.id}"
  end

  test "returns list of messages after join", %{socket: socket, user: user, room: room} do
    Conversation.create_message(user, room, %{"content" => "Hello from Test"})

    {:ok, messages, _} = subscribe_and_join(socket, "room:#{room.id}", %{})

    messages_template = %{
      messages: [
        %{content: "Hello from Test", user: %{username: user.username}}
      ]
    }

    assert messages == messages_template
  end

  test "broadcasting presence", %{socket: socket, user: user, room: room} do
    {:ok, _, _socket} = subscribe_and_join(socket, "room:#{room.id}", %{})

    user_data = %{
      typing: false, user_id: user.id, username: user.username
    }
    assert_push "presence_state", user_data
    assert_broadcast "presence_diff", user_data
  end
end
