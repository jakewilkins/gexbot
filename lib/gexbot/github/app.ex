defmodule Gexbot.Github.App do
  alias Tentacat.Client
  alias Gexbot.Github.App.Token

  def client_from(%{installation_id: _id} = spec) do
    Client.new(Token.installation(spec))
  end

  def client_from(%{user_id: _id} = spec) do
    Client.new(Token.user(spec))
  end

  def client_from(%{oauth_code: _id} = spec) do
    Client.new(Token.user(spec))
  end

  def client_from(%{app_id: _id, private_key: _key_path} = spec) do
    Client.new(Token.jwt(spec))
  end
end
