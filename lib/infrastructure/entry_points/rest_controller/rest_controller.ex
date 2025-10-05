defmodule MsLoginRegistrationE.Infrastructure.EntryPoints.RestController do
  use Plug.Router
  plug :match
  plug :dispatch

  plug Plug.Parsers,
    parsers: [:json],
    pass: ["application/json"],
    json_decoder: Jason

  post "/signup" do
     send_resp(conn, 201, "Ok signup")
  end

   post "/signin" do
     send_resp(conn, 200, "Ok signin")
  end

  match _ do
    send_resp(conn, 404, "Not Found")
  end
end
