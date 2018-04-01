defmodule PraterWeb.RegistrationControllerTest do
  use PraterWeb.ConnCase

  test "GET /registrations/new", %{conn: conn} do
    conn = get conn, "/registrations/new"
    assert html_response(conn, 200) =~ "Sign Up"
  end

  @params %{
    email: "user@example.com",
    username: "username",
    password: "password",
    password_confirmation: "password"
  }
  test "POST /registrations", %{conn: conn} do
    conn = post conn, "/registrations", [registration: @params]

    assert redirected_to(conn) == "/"
    assert get_flash(conn, :info) == "You have successfully signed up!"
    assert get_last_user().email == "user@example.com"
  end

  defp get_last_user do
    alias Prater.Auth.User
    import Ecto.Query

    Prater.Repo.one(from u in User, order_by: [desc: u.id], limit: 1)
  end
end
