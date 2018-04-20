defmodule PraterWeb.SignInTest do
  use PraterWeb.ConnCase
  use Hound.Helpers

  import Prater.AuthHelpers

  hound_session()

  test "user can sign in with valid credentials" do
    create_user()
    navigate_to("/")
    find_element(:link_text, "Sign In") |> click()

    assert current_path() == "/sessions/new"

    fill_field({:id, "session_email"}, "user@example.com")
    fill_field({:id, "session_password"}, "password")

    find_element(:css, "button.btn-primary[type='submit']") |> click()

    assert String.contains?(page_source(), "You have successfully signed in!")
  end
end
