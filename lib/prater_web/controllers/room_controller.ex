defmodule PraterWeb.RoomController do
  use PraterWeb, :controller

  def index(conn, _params) do
    rooms = Prater.Conversation.list_rooms()
    render conn, "index.html", rooms: rooms
  end
end
