defmodule Plug.Gexbot do
  defmodule ClientFetcher do
  end

  defmodule WebhookSecretValidator do
    import Plug.Crypto, only: [secure_compare: 2]
    import Plug.Conn, only: [assign: 3, read_body: 2]

    def init(opts), do: opts

    def call(conn, _opts) do
      with {_header, signature} <- List.keyfind(conn.req_headers, "x-hub-signature", 0),
           webhook_secret when is_bitstring(webhook_secret) <- get_webhook_secret(),
           {hmac_algo, server_signature} <- get_hmac_algo(signature) do

             {:ok, full_body, conn} = local_read_body(conn)

             generated_signature = hmac(hmac_algo, webhook_secret, full_body)
             display_debug(server_signature, generated_signature)
             if secure_compare(server_signature, generated_signature) do
               assign(conn, :webhook_signature, :verified)
             else
               assign(conn, :webhook_signature, :invalid)
             end
      else
        nil -> assign(conn, :webhook_signature, :unsigned)
        :webhook_secret_not_set -> assign(conn, :webhook_signature, :webhook_secret_not_set)
        [{:invalid_hmac_alg, hmac_algo}] -> assign(conn, :webhook_signature, :invalid_hmac_algo)
      end
    end

    defp get_hmac_algo("sha1=" <> signature), do: {:sha, signature}
    defp get_hmac_algo("sha256=" <> signature), do: {:sha256, signature}

    defp hmac(algo, key, data) when is_map(data) do
      hmac(algo, key, data)
    end

    defp hmac(algo, key, data) do
      :crypto.hmac(algo, key, data) |> bytes_to_string()
    end

    defp bytes_to_string(bytes) do
      Base.encode16(bytes, case: :lower)
    end

    defp get_webhook_secret do
      Application.get_env(:gexbot, :webhook_secret, :webhook_secret_not_set)
    end

    defp local_read_body(conn, start \\ "") do
      case read_body(conn, []) do
        {:ok, data, conn} ->
          conn = %{conn | body_params: Poison.decode!(data)}
          {:ok, start <> data, conn}
        {:error, reason} -> {:read_body_error, reason}
        {:more, body, conn} -> local_read_body(conn, body)
      end
    end
  end
end
