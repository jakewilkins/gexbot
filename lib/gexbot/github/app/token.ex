defmodule Gexbot.Github.App.Token do
  defstruct([type: nil, secret: nil, expiry: nil])

  import Joken, only: [token: 1, sign: 2, rs256: 1, get_compact: 1, with_iat: 1, with_exp: 2]

  def jwt(%{app_id: id, private_key: %JOSE.JWK{} = key}) do
    token = %{iss: id}
    |> token
    |> with_iat
    |> with_exp(current_time() + 4 * 60)
    |> sign(rs256(key))
    |> get_compact
  end
  def jwt(%{app_id: _id, private_key: key} = spec) do
    jwt(%{spec | private_key: key_from_string_or_path(key)})
  end

  def installation(%{installation_id: inst_id} = spec) do

  end

  defp key_from_string_or_path(key) do
    JOSE.JWK.from_pem_file(key)
  end

  defp current_time() do
    {mega, secs, _} = :os.timestamp()
    mega * 1_000_000 + secs
  end
end
