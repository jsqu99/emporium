defmodule Hello.Router do
  use Emporium.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end


  scope "/", Emporium do
    pipe_through :browser
    get "/hello", HelloController, :index
  end
end