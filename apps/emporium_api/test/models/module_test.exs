defmodule EmporiumApi.ModuleTest do
  use EmporiumApi.ModelCase

  alias Emporium.Module

  @valid_attrs %{is_active: true, name: "mod_test", priority: 42, version: "0.0.1"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Module.changeset(%Module{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Module.changeset(%Module{}, @invalid_attrs)
    refute changeset.valid?
  end
end
