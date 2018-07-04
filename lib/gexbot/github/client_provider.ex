defmodule Gexbot.Github.ClientProvider do
  use GenServer
  alias Tentacat.Client
  alias Gexbot.Github.App.Token

  @name __MODULE__
  @default_url "https://api.github.com"

  def start_link(url \\ @default_url) do
    GenServer.start_link(@name, [url], name: @name)
  end

  def init(url) do
    {:ok, %{requests: [], url: url}}
  end

  def set_request_auth(spec) do
    GenServer.call(@name, {:set_request, spec})
  end

  def set_request_auth(key, spec) do
    GenServer.call(@name, {:set_request, key, spec})
  end

  def get_client() do
    {:ok, client} = GenServer.call(@name, :get_client)
    client
  end

  def clear_controller() do
    GenServer.cast(@name, :set_request)
  end

  def handle_call({:set_request, spec}, from, state) do
    {:no_reply, %{requests: [[{from, spec}] | state.requests]}}
  end

  def handle_call({:set_request, key, spec}, from, state) do
    {:no_reply, %{requests: [[{key, spec}] | state.requests]}}
  end

  def handle_call({:get_client, key}, from, state) do
    client_spec = Keyword.fetch(state.requests, key)

    {:reply, }
  end
  def handle_call(:get_client, from, state) do
    client_spec = Keyword.fetch(state.requests, from)

    {:reply, }
  end

end
