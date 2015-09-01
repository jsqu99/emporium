defmodule EmporiumAdmin.ProductController do
  use EmporiumAdmin.Web, :controller

  alias EmporiumAdmin.EmporiumHTTPApi

  plug :scrub_params, "product" when action in [:create, :update]

  def index(conn, _params) do
    products = EmporiumHTTPApi.get!("/api/products").body[:data]
    render(conn, "index.html", products: products)
  end

  def new(conn, _params) do
    changeset = ""
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"product" => product_params}) do
    changeset = ""

    case changeset do
      {:ok, _product} ->
        conn
        |> put_flash(:info, "Product created successfully.")
        |> redirect(to: product_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
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
