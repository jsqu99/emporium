defmodule EmporiumAdmin.ProductController do
  use EmporiumAdmin.Web, :controller

  alias Emporium.HTTP.API

  plug :scrub_params, "product" when action in [:create, :update]

  def index(conn, params) do
    products = API.Client.get_products!(params)
    render(conn, "index.html", products: products)
  end

  def new(conn, _params) do
    product = %{}
    render(conn, "new.html", product: product)
  end

  def create(conn, params) do
    response = API.Client.create_product!(params)
    case {response.body, response.status_code} do
      {_, 201} ->
        conn
        |> put_flash(:info, "Product created successfully.")
        |> redirect(to: product_path(conn, :index))
      {body, 422} ->
        conn = assign(conn, :errors, body[:errors])
        render(conn, "new.html", product: params)
    end
  end

  def show(conn, %{"id" => id}) do
    product = API.Client.get_product!(id)
    render(conn, "show.html", product: product)
  end

  def edit(conn, %{"id" => id}) do
    product = API.Client.get_product!(id)
    render(conn, "edit.html", product: product)
  end

  def update(conn, %{"id" => id, "product" => product_params}) do
    response = API.Client.update_product!(id, %{product: product_params})
    product = Map.put(product_params, "id", id)

    case {response.body, response.status_code} do
      {_, 200} ->
        conn
        |> put_flash(:info, "Product updated successfully.")
        |> redirect(to: product_path(conn, :show, product["id"]))
      {body, 422} ->
        conn = assign(conn, :errors, body[:errors])
        render(conn, "edit.html", product: product)
    end
  end

  def delete(conn, %{"id" => id}) do
    response = API.Client.delete_product!(id)
    case response.status_code do
      204 ->
        conn
        |> put_flash(:info, "Product deleted successfully.")
        |> redirect(to: product_path(conn, :index))
      404 ->
        conn
        |> put_flash(:error, "Product id #{id} Not Found.")
        |> redirect(to: product_path(conn, :index))
    end
  end
end
