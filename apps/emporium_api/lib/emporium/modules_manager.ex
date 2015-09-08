defmodule Emporium.ModulesManager do
  alias EmporiumApi.Repo
  import Ecto.Query

  def start_link do
    {:ok, self}
  end

  def active_modules do
    query = from m in Emporium.Module,
          where: m.is_active,
         select: m
    Repo.all(query)
  end

  def active_plugs do
    active_modules |> Enum.map(
      fn(mod) -> 
        ("Elixir." <> (mod.name |> String.slice(4..-1) |> String.capitalize) <> ".Router") |> String.to_existing_atom
      end
    )
  end
end