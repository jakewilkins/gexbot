defmodule Gexbot.Github.App do
  def client_from(%{installation_id: _id} = spec) do
    Client.new(%{token: Token.installation(spec)})
  end

  def client_from(%{user_id: _id} = spec) do
    Client.new(%{token: Token.user(spec)})
  end

  def client_from(%{app_id: _id, private_key: _key_path} = spec) do
    Client.new(%{jwt: Token.jwt(spec)})
  end
end
