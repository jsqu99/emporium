defmodule EmporiumAdmin.CategoryController do
  use EmporiumAdmin.Web, :controller

  alias Emporium.HTTP.API

  plug :scrub_params, "category" when action in [:create, :update]

  def index(conn, params) do
    categories = API.Client.get_categories!(params)
    render(conn, "index.html", categories: categories)
  end

  def new(conn, _params) do
    category = %{}
    render(conn, "new.html", category: category)
  end

  def create(conn, params) do
    response = API.Client.create_category!(params)
    case {response.body, response.status_code} do
      {_, 201} ->
        conn
        |> put_flash(:info, "Category created successfully.")
        |> redirect(to: category_path(conn, :index))
      {body, 422} ->
        conn = assign(conn, :errors, body[:errors])
        render(conn, "new.html", category: params)
    end
  end

  def show(conn, %{"id" => id}) do
    category = API.Client.get_category!(id)
    render(conn, "show.html", category: category)
  end

  def edit(conn, %{"id" => id}) do
    category = API.Client.get_category!(id)
    render(conn, "edit.html", category: category)
  end

  def update(conn, %{"id" => id, "category" => category_params}) do
    response = API.Client.update_category!(id, %{category: category_params})
    category = Map.put(category_params, "id", id)

    case {response.body, response.status_code} do
      {_, 200} ->
        conn
        |> put_flash(:info, "Category updated successfully.")
        |> redirect(to: category_path(conn, :show, category["id"]))
      {body, 422} ->
        conn = assign(conn, :errors, body[:errors])
        render(conn, "edit.html", category: category)
    end
  end

  def delete(conn, %{"id" => id}) do
    response = API.Client.delete_category!(id)
    case response.status_code do
      204 ->
        conn
        |> put_flash(:info, "Category deleted successfully.")
        |> redirect(to: category_path(conn, :index))
      404 ->
        conn
        |> put_flash(:error, "Category id #{id} Not Found.")
        |> redirect(to: category_path(conn, :index))
    end
  end
end
