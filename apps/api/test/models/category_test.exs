defmodule EmporiumApi.CategoryTest do
  use EmporiumApi.ModelCase

  alias Emporium.Category

  @valid_attrs %{name: "some content", parent_id: 42, permalink: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Category.changeset(%Category{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Category.changeset(%Category{}, @invalid_attrs)
    refute changeset.valid?
  end
end
