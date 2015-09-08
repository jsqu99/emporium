defmodule EmporiumApi.Repo.Migrations.CreateModule do
  use Ecto.Migration

  def change do
    create table(:emporium_modules) do
      add :name, :string
      add :is_active, :boolean, default: false
      add :priority, :integer
      add :version, :string

      timestamps
    end

  end
end
