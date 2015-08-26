defmodule EmporiumApi.CategoryView do
  use EmporiumApi.Web, :view

  def render("index.json", %{emporium_categories: emporium_categories}) do
    %{data: render_many(emporium_categories, EmporiumApi.CategoryView, "category.json")}
  end

  def render("show.json", %{category: category}) do
    %{data: render_one(category, EmporiumApi.CategoryView, "category.json")}
  end

  def render("category.json", %{category: category}) do
    %{id: category.id,
      name: category.name,
      permalink: category.permalink,
      parent_id: category.parent_id}
  end
end
