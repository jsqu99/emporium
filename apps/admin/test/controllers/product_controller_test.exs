defmodule EmporiumAdmin.ProductControllerTest do
  use EmporiumAdmin.ConnCase

  @valid_attrs %{name: "Hat", permalink: "hat", description: "some text", category_id: 1}
  @invalid_attrs %{name: "", permalink: "", description: "", category_id: nil}

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
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, product_path(conn, :create), %{"product" => @invalid_attrs}
    assert html_response(conn, 200) =~ "New product"
  end

  test "shows chosen resource", %{conn: conn} do
    product = Emporium.HTTP.API.Client.create_product!(%{product: @valid_attrs}).body[:data]
    conn = get conn, product_path(conn, :show, product["id"])
    assert html_response(conn, 200) =~ "Show product"
  end

  @tag :pending
  test "renders page not found when id is nonexistent", %{conn: conn} do
    get conn, product_path(conn, :show, -1)
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    product = Emporium.HTTP.API.Client.create_product!(%{product: @valid_attrs}).body[:data]
    conn = get conn, product_path(conn, :edit, product["id"])
    assert html_response(conn, 200) =~ "Edit product"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    product = Emporium.HTTP.API.Client.create_product!(%{product: @valid_attrs}).body[:data]
    conn = put conn, product_path(conn, :update, product["id"]), %{product: @valid_attrs}
    assert redirected_to(conn) == product_path(conn, :show, product["id"])
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    product = Emporium.HTTP.API.Client.create_product!(%{product: @valid_attrs}).body[:data]
    conn = put conn, product_path(conn, :update, product["id"]), product: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit product"
  end

  test "deletes chosen resource", %{conn: conn} do
    product = Emporium.HTTP.API.Client.create_product!(%{product: @valid_attrs}).body[:data]
    conn = delete conn, product_path(conn, :delete, product["id"])
    assert redirected_to(conn) == product_path(conn, :index)
  end
end
