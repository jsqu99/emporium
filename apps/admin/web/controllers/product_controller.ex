defmodule EmporiumAdmin.ProductController do
  use EmporiumAdmin.Web, :controller

  alias Emporium.HTTP.API.Client, as: APIClient

  plug :scrub_params, "product" when action in [:create, :update]

  def index(conn, params) do
    products = APIClient.get_products!(params)
    render(conn, "index.html", products: products)
  end

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, params) do
    response = APIClient.create_product!(params)
    case {response.body, response.status_code} do
      {_, 201} ->
        conn
        |> put_flash(:info, "Product created successfully.")
        |> redirect(to: product_path(conn, :index))
      {body, 422} ->
        conn = assign(conn, :errors, body[:errors])
        render(conn, "new.html")
    end
  end

  def show(conn, %{"id" => id}) do
    product = ""
    render(conn, "show.html", product: product)
  end

  def edit(conn, %{"id" => id}) do
    product = ""
    changeset = ""
    render(conn, "edit.html", product: product, changeset: changeset)
  end

  def update(conn, %{"id" => id, "product" => product_params}) do
    product = ""
    changeset = ""

    case "" do
      {:ok, product} ->
        conn
        |> put_flash(:info, "Product updated successfully.")
        |> redirect(to: product_path(conn, :show, product))
      {:error, changeset} ->
        render(conn, "edit.html", product: product, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    product = ""

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    #Repo.delete!(product)

    conn
    |> put_flash(:info, "Product deleted successfully.")
    |> redirect(to: product_path(conn, :index))
  end
end
