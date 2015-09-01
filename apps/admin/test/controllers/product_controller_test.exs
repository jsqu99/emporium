defmodule EmporiumAdmin.ProductControllerTest do
  use EmporiumAdmin.ConnCase

  alias EmporiumAdmin.Product
  @valid_attrs %{}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, product_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing products"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, product_path(conn, :new)
    assert html_response(conn, 200) =~ "New product"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, product_path(conn, :create), product: @valid_attrs
    assert redirected_to(conn) == product_path(conn, :index)
    assert Repo.get_by(Product, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, product_path(conn, :create), product: @invalid_attrs
    assert html_response(conn, 200) =~ "New product"
  end

  test "shows chosen resource", %{conn: conn} do
    product = Repo.insert! %Product{}
    conn = get conn, product_path(conn, :show, product)
    assert html_response(conn, 200) =~ "Show product"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, product_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    product = Repo.insert! %Product{}
    conn = get conn, product_path(conn, :edit, product)
    assert html_response(conn, 200) =~ "Edit product"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    product = Repo.insert! %Product{}
    conn = put conn, product_path(conn, :update, product), product: @valid_attrs
    assert redirected_to(conn) == product_path(conn, :show, product)
    assert Repo.get_by(Product, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    product = Repo.insert! %Product{}
    conn = put conn, product_path(conn, :update, product), product: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit product"
  end

  test "deletes chosen resource", %{conn: conn} do
    product = Repo.insert! %Product{}
    conn = delete conn, product_path(conn, :delete, product)
    assert redirected_to(conn) == product_path(conn, :index)
    refute Repo.get(Product, product.id)
  end
end
