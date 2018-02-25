defmodule PraterWeb.RoomController do
  use PraterWeb, :controller

  alias Prater.Conversation
  alias Prater.Conversation.Room
  alias Prater.Auth.Authorizer

  plug PraterWeb.Plugs.AuthenticateUser when action not in [:index]
  plug :authorize_user when action in [:edit, :update, :delete]

  def index(conn, _params) do
    rooms = Conversation.list_rooms()
    render conn, "index.html", rooms: rooms
  end

  def new(conn, _params) do
    changeset = Conversation.change_room(%Room{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"room" => room_params}) do
    case Conversation.create_room(conn.assigns.current_user, room_params) do
      {:ok, room} ->
        conn
        |> put_flash(:info, "Room created successfully.")
        |> redirect(to: room_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    room = Conversation.get_room!(id)
    render(conn, "show.html", room: room)
  end

  def edit(conn, %{"id" => id}) do
    room = Conversation.get_room!(id)
    changeset = Conversation.change_room(room)
    render(conn, "edit.html", room: room, changeset: changeset)
  end

  def update(conn, %{"id" => id, "room" => room_params}) do
    room = Conversation.get_room!(id)

    case Conversation.update_room(room, room_params) do
      {:ok, room} ->
        conn
        |> put_flash(:info, "Room updated successfully.")
        |> redirect(to: room_path(conn, :show, room))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", room: room, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    room = Conversation.get_room!(id)
    {:ok, _room} = Conversation.delete_room(room)

    conn
    |> put_flash(:info, "Room deleted successfully.")
    |> redirect(to: room_path(conn, :index))
  end

  defp authorize_user(conn, _params) do
    %{params: %{"id" => room_id}} = conn
    room = Conversation.get_room!(room_id)

    if Authorizer.can_manage?(conn.assigns.current_user, room) do
      conn
    else
      conn
      |> put_flash(:error, "You are not authorized to access that page")
      |> redirect(to: room_path(conn, :index))
      |> halt()
    end
  end
end
