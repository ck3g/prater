defmodule PraterWeb.WelcomePageTest do
  use PraterWeb.ConnCase
  use Hound.Helpers

  hound_session()

  @tag :ui
  test "page has a correct title" do
    navigate_to("/")

    assert page_title() == "Hello Prater!"
    assert String.contains?(page_source(), "Welcome to Prater")
  end
end
