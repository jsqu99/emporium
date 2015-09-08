defmodule Emporium.HTTP.API.Client do
  use HTTPoison.Base

  def get_product!(id) do
    __MODULE__.get!("/api/products/#{id}").body[:data]
  end

  def get_products!(params) do
    __MODULE__.get!("/api/products", [], params: params).body[:data]
  end

  def create_product!(params) do
    __MODULE__.post!("/api/products", Poison.encode!(params))
  end

  def delete_product!(id) do
    __MODULE__.delete!("/api/products/#{id}")
  end

  def update_product!(id, params) do
    __MODULE__.put!("/api/products/#{id}", Poison.encode!(params))
  end

  def get_category!(id) do
    __MODULE__.get!("/api/categories/#{id}").body[:data]
  end

  def get_categories!(params) do
    __MODULE__.get!("/api/categories", [], params: params).body[:data]
  end

  def create_category!(params) do
    __MODULE__.post!("/api/categories", Poison.encode!(params))
  end

  def delete_category!(id) do
    __MODULE__.delete!("/api/categories/#{id}")
  end

  def update_category!(id, params) do
    __MODULE__.put!("/api/categories/#{id}", Poison.encode!(params))
  end

  def process_url(url) do
    {:ok, api_url} = Application.fetch_env(:emporium_admin, :api_url)
    api_url <> url
  end

  def process_response_body(body) do
    try do
      body
      |> Poison.decode!
      |> Enum.map(fn({k,v}) -> {String.to_atom(k), v} end )
    rescue
      _ -> body
    end
  end

  def process_request_headers(headers) do
    [{'content-type', 'application/json'} | headers]
  end

end
