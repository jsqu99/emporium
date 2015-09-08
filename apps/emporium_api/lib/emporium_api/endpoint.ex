defmodule EmporiumApi.Endpoint do
  use Phoenix.Endpoint, otp_app: :emporium_api

  socket "/socket", EmporiumApi.UserSocket

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phoenix.digest
  # when deploying your static files in production.
  plug Plug.Static,
    at: "/", from: :emporium_api, gzip: false,
    only: ~w(css fonts images js favicon.ico robots.txt)

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    socket "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
  end

  plug Plug.RequestId
  plug Plug.Logger

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  plug Plug.Session,
    store: :cookie,
    key: "_emporium_api_key",
    signing_salt: "szyqAi16"


  def call(conn, _opts) do
    conn = put_in conn.secret_key_base, config(:secret_key_base)
    conn = conn
    |> Plug.Conn.put_private(:phoenix_endpoint, __MODULE__)
    |> put_script_name()
    |> phoenix_pipeline()

    conn = Emporium.ModulesManager.active_plugs 
    |> Enum.reduce(conn, fn(mod, conn) -> :erlang.apply(mod, :call, [conn, []]) end )

    conn |> EmporiumApi.Router.call([])
  end
end
