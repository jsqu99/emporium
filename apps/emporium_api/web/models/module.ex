defmodule Emporium.Module do
  use EmporiumApi.Web, :model

  schema "emporium_modules" do
    field :name, :string
    field :is_active, :boolean, default: false
    field :priority, :integer, default: 500
    field :version, :string

    timestamps
  end

  @required_fields ~w(names)
  @optional_fields ~w(is_active priority version)

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
