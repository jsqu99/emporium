defmodule EmporiumApi.Repo.Migrations.CreateProduct do
  use Ecto.Migration

  def change do
    create table(:emporium_products) do
      add :name, :string
      add :permalink, :string
      add :description, :text
      add :is_digital, :boolean, default: false
      add :category_id, :integer

      timestamps
    end
  end
end