defmodule EmporiumAdmin.EmporiumHTTPApi do
  use HTTPoison.Base

  def process_url(url) do
    {:ok, api_url} = Application.fetch_env(:emporium_admin, :api_url)
    api_url <> url
  end

  def process_response_body(body) do
    body
    |> Poison.decode!
    |> Enum.map(fn({k,v}) -> {String.to_atom(k), v} end )
  end

end
