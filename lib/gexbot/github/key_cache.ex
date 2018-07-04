defmodule Gexbot.Github.KeyCache do
  use Agent

  @name __MODULE__

  def start_link(_) do
    Agent.start_link(fn -> MapSet.new end, name: @name)
  end

  def get_key(id) do
    Agent.get(@name, fn(set) ->
      id in set
    end)
  end

  def set_key(id, key, expiry) do
    Agent.update(@name, fn(set) ->
    end)
  end
end
