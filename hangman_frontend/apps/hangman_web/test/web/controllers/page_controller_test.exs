defmodule Hangman.Web.PageControllerTest do
  use Hangman.Web.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Hangman Game"
  end
end
