defmodule EmporiumAdmin.PageController do
  use EmporiumAdmin.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
