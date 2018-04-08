defmodule PraterWeb.UserSocketTest do
  use PraterWeb.ChannelCase, async: true
  alias PraterWeb.UserSocket

  test "authenticate with valid token" do
    token = Phoenix.Token.sign(@endpoint, "user token", 503)

    assert {:ok, socket} = connect(UserSocket, %{"token" => token})
    assert socket.assigns.current_user_id == 503
  end

  test "authenticate with invalid token" do
    assert :error = connect(UserSocket, %{"token" => "invalid-token"})
    assert :error = connect(UserSocket, %{})
  end
end
