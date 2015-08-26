defmodule EmporiumApi.CategoryController do
  use EmporiumApi.Web, :controller

  alias Emporium.Category

  plug :scrub_params, "category" when action in [:create, :update]

  def index(conn, _params) do
    emporium_categories = Repo.all(Category)
    render(conn, "index.json", emporium_categories: emporium_categories)
  end

  def create(conn, %{"category" => category_params}) do
    changeset = Category.changeset(%Category{}, category_params)

    case Repo.insert(changeset) do
      {:ok, category} ->
        conn
        |> put_status(:created)
        |> render("show.json", category: category)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(EmporiumApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    category = Repo.get!(Category, id)
    render conn, "show.json", category: category
  end

  def update(conn, %{"id" => id, "category" => category_params}) do
    category = Repo.get!(Category, id)
    changeset = Category.changeset(category, category_params)

    case Repo.update(changeset) do
      {:ok, category} ->
        render(conn, "show.json", category: category)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(EmporiumApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    category = Repo.get!(Category, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    category = Repo.delete!(category)

    send_resp(conn, :no_content, "")
  end
end
