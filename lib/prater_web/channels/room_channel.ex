defmodule PraterWeb.RoomChannel do
  use PraterWeb, :channel

  def join(channel_name, _params, socket) do
    {:ok, %{channel: channel_name}, socket}
  end

  def handle_in("message:add", %{"message" => content}, socket) do
    broadcast!(socket, "room:lobby:new_message", %{content: content})
    {:reply, :ok, socket}
  end
end
