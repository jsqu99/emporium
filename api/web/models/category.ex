defmodule Emporium.Category do
  use EmporiumApi.Web, :model

  schema "emporium_categories" do
    field :name, :string
    field :permalink, :string
    field :parent_id, :integer

    has_many :products, Emporium.Product
    timestamps
  end

  @required_fields ~w(name permalink)
  @optional_fields ~w(parent_id)

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
