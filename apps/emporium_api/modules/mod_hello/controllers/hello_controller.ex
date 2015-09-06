defmodule Emporium.HelloController do
  use EmporiumApi.Web, :controller

  def index(conn, _params) do
    render conn, "index.html", layout: {Emporium.HelloLayoutView, "app.html"}
  end
end