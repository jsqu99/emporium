defmodule Emporium.HTTP.API.Client do
  use HTTPoison.Base

  def get_products!(params) do
    __MODULE__.get!("/api/products", [], params: params).body[:data]
  end

  def create_product!(params) do
    __MODULE__.post!("/api/products", Poison.encode!(params))
  end

  def process_url(url) do
    {:ok, api_url} = Application.fetch_env(:emporium_admin, :api_url)
    api_url <> url
  end

  def process_response_body(body) do
    body
    |> Poison.decode!
    |> Enum.map(fn({k,v}) -> {String.to_atom(k), v} end )
  end

  def process_request_headers(headers) do
    [{'content-type', 'application/json'} | headers]
  end

end
