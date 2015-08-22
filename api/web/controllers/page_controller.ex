defmodule EmporiumApi.PageController do
  use EmporiumApi.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
