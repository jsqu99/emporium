defmodule EmporiumApi.ProductTest do
  use EmporiumApi.ModelCase

  alias Emporium.Product

  @valid_attrs %{category_id: 1, description: "some content", is_digital: true, name: "some content", permalink: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Product.changeset(%Product{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Product.changeset(%Product{}, @invalid_attrs)
    refute changeset.valid?
  end
end
