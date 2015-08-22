defmodule EmporiumApi.ProductView do
  use EmporiumApi.Web, :view

  def render("index.json", %{emporium_products: emporium_products}) do
    %{data: render_many(emporium_products, EmporiumApi.ProductView, "product.json")}
  end

  def render("show.json", %{product: product}) do
    %{data: render_one(product, EmporiumApi.ProductView, "product.json")}
  end

  def render("product.json", %{product: product}) do
    %{id: product.id,
      name: product.name,
      permalink: product.permalink,
      description: product.description,
      category_id: product.category_id,
      is_digital: product.is_digital}
  end
end
