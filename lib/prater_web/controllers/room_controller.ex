defmodule PraterWeb.RoomController do
  use PraterWeb, :controller

  def index(conn, _params) do
    rooms = Prater.Conversation.list_rooms()
    render conn, "index.html", rooms: rooms
  end

  def new(conn, _params) do
    alias Prater.Conversation.Room
    changeset = Room.changeset(%Room{}, %{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"room" => room_params}) do
    alias Prater.Conversation.Room
    alias Prater.Repo
    %Room{}
    |> Room.changeset(room_params)
    |> Repo.insert()
    |> case do
      {:ok, room} ->
        conn
        |> put_flash(:info, "Room created successfully.")
        |> redirect(to: room_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
