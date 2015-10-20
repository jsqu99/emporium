defmodule EmporiumAdmin.Router do
  use EmporiumAdmin.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", EmporiumAdmin do
    pipe_through :browser # Use the defaultobrowser stack
    get "/", PageController, :index
    resources "/products", ProductController
    resources "/categories", CategoryController
  end

  # Other scopes may use custom stacks.
  # scope "/api", EmporiumAdmin do
  #   pipe_through :api
  # end
end
