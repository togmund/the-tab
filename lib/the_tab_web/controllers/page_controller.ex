defmodule TheTabWeb.PageController do
  use TheTabWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
