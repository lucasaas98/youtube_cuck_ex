defmodule YoutubeCuckWeb.PageController do
  use YoutubeCuckWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
