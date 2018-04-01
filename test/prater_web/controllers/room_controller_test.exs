defmodule PraterWeb.RoomControllerTest do
  use PraterWeb.ConnCase

  setup %{conn: conn} = config do
    if email = config[:sign_in_as] do
      user = create_user(email)
      conn = Plug.Test.init_test_session(
        build_conn(), current_user_id: user.id
      )

      {:ok, conn: conn, user: user}
    else
      :ok
    end
  end

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Welcome to Prater"
  end

  @tag sign_in_as: "user@example.com"
  test "GET /room/:id", %{conn: conn, user: user} do
    {:ok, room} = Prater.Conversation.create_room(
      user,
      %{name: "Lobby", description: "The general chat room"}
    )

    conn = get(conn, "/rooms/#{room.id}")

    assert html_response(conn, 200) =~ "<h2>Lobby</h2>"
    assert html_response(conn, 200) =~ "<div>The general chat room</div>"
  end
end
