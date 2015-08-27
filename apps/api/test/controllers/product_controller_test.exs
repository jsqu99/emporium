defmodule EmporiumApi.ProductControllerTest do
  use EmporiumApi.ConnCase

  alias Emporium.Product
  @valid_attrs %{category_id: 1, description: "some content", is_digital: false, name: "some content", permalink: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, product_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    product = Repo.insert! %Product{}
    conn = get conn, product_path(conn, :show, product)
    assert json_response(conn, 200)["data"]["id"] == product.id
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, product_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, product_path(conn, :create), product: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Product, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, product_path(conn, :create), product: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    product = Repo.insert! %Product{}
    conn = put conn, product_path(conn, :update, product), product: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Product, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    product = Repo.insert! %Product{}
    conn = put conn, product_path(conn, :update, product), product: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    product = Repo.insert! %Product{}
    conn = delete conn, product_path(conn, :delete, product)
    assert response(conn, 204)
    refute Repo.get(Product, product.id)
  end
end
