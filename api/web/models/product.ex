defmodule Emporium.Product do
  use EmporiumApi.Web, :model

  schema "emporium_products" do
    field :name, :string
    field :permalink, :string
    field :description, :string
    belongs_to :category, Emporium.Category
    field :is_digital, :boolean, default: false

    timestamps
  end

  @required_fields ~w(name permalink description category_id)
  @optional_fields ~w(is_digital)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
