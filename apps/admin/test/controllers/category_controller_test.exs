defmodule EmporiumAdmin.CategoryControllerTest do
  use EmporiumAdmin.ConnCase

  @valid_attrs %{name: "Some Name", permalink: "some-link"}
  @invalid_attrs %{name: "Forgot Permalink", permalink: ""}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

 test "lists all entries on index", %{conn: conn} do
    conn = get conn, category_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing categories"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, category_path(conn, :new)
    assert html_response(conn, 200) =~ "New category"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, category_path(conn, :create), category: @valid_attrs
    assert redirected_to(conn) == category_path(conn, :index)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, category_path(conn, :create), %{"category" => @invalid_attrs}
    assert html_response(conn, 200) =~ "New category"
  end

  test "shows chosen resource", %{conn: conn} do
    category = Emporium.HTTP.API.Client.create_category!(%{category: @valid_attrs}).body[:data]
    conn = get conn, category_path(conn, :show, category["id"])
    assert html_response(conn, 200) =~ "Show category"
  end

  @tag :pending
  test "renders page not found when id is nonexistent", %{conn: conn} do
    get conn, category_path(conn, :show, -1)
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    category = Emporium.HTTP.API.Client.create_category!(%{category: @valid_attrs}).body[:data]
    conn = get conn, category_path(conn, :edit, category["id"])
    assert html_response(conn, 200) =~ "Edit category"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    category = Emporium.HTTP.API.Client.create_category!(%{category: @valid_attrs}).body[:data]
    conn = put conn, category_path(conn, :update, category["id"]), %{category: @valid_attrs}
    assert redirected_to(conn) == category_path(conn, :show, category["id"])
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    category = Emporium.HTTP.API.Client.create_category!(%{category: @valid_attrs}).body[:data]
    conn = put conn, category_path(conn, :update, category["id"]), category: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit category"
  end

  test "deletes chosen resource", %{conn: conn} do
    category = Emporium.HTTP.API.Client.create_category!(%{category: @valid_attrs}).body[:data]
    conn = delete conn, category_path(conn, :delete, category["id"])
    assert redirected_to(conn) == category_path(conn, :index)
  end
end
