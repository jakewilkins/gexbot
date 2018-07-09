defmodule Gexbot.Github.App.Token do
  alias Gexbot.Github.{App, KeyCache}
  defstruct([type: nil, secret: nil, expiry: nil, cached: false])

  import Joken, only: [token: 1, sign: 2, rs256: 1, get_compact: 1, with_iat: 1, with_exp: 2]

  def jwt(%{app_id: id, private_key: %JOSE.JWK{} = key}) do
    token = %{iss: id}
    |> token
    |> with_iat
    |> with_exp(current_time() + 4 * 60)
    |> sign(rs256(key))
    |> get_compact
    %{jwt: token, meta: %__MODULE__{type: :jwt, secret: token}}
  end
  def jwt(%{app_id: _id, private_key: key} = spec) do
    jwt(%{spec | private_key: key_from_string_or_path(key)})
  end

  def installation(%{installation_id: inst_id} = spec) do
    installation_key = case KeyCache.get_key(:installation, inst_id) do
      :cache_unavailable ->
        jwt_client = App.client_from(Map.take(spec, [:app_id, :private_key]))
        fetch_installation_key(jwt_client, inst_id)
      {:cached, key, expiry} ->
        {:cached, key, expiry}
    end
    case installation_key do
      {:cached, key, expiry} ->
        %{access_token: key, meta: %__MODULE__{type: :installation, secret: key, cached: true, expiry: expiry}}
      {:valid, key} ->
        %{access_token: key, meta: %__MODULE__{type: :installation, secret: key}}
    end
  end

  defp key_from_string_or_path(key) do
    JOSE.JWK.from_pem_file(key)
  end

  defp current_time() do
    {mega, secs, _} = :os.timestamp()
    mega * 1_000_000 + secs
  end

  defp fetch_installation_key(jwt_client, inst_id) do
    installation_key_path = "installations/#{inst_id}/access_tokens"
    case Tentacat.post(installation_key_path, jwt_client) do
      {201, response, _} ->
        {:valid, KeyCache.set_key(:installation, inst_id, response["token"], response["expires_at"])}
      {_, response, _} ->
        {:invalid, response}
    end
  end
end
