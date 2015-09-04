defmodule EmporiumApi.Repo.Migrations.CreateCategory do
  use Ecto.Migration

  def change do
    create table(:emporium_categories) do
      add :name, :string
      add :permalink, :string
      add :parent_id, :integer

      timestamps
    end

  end
end
