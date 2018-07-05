defmodule Gexbot.Github.KeyCache do
  use Agent

  @name __MODULE__

  def start_link() do
    Agent.start_link(fn -> %{} end, name: @name)
  end

  def show_cache do
    Agent.get(@name, fn(map) -> map end)
  end

  def get_key(type, id) do
    with {key, expiry} <- Agent.get(@name, fn(map) -> Map.get(map, "#{type}.#{id}") end),
               :cached <- compare_time(expiry)  do
      {:cached, key, expiry}
    else
      nil ->
        :cache_unavailable
      :expired ->
        Agent.update(@name, fn(map) -> Map.delete(map, "#{type}.#{id}") end)
        :cache_unavailable
    end
  end

  def set_key(type, id, key, expiry) when is_bitstring(expiry) do
    set_key(type, id, key, Timex.parse!(expiry, "{ISO:Extended:Z}"))
  end

  def set_key(type, id, key, expiry) do
    Agent.update(@name, fn(map) ->
      Map.put(map, "#{type}.#{id}", {key, expiry})
    end)
    key
  end

  defp compare_time(expiry) do
    comp = Timex.diff(expiry, Timex.now)
    if comp > 0, do: :cached, else: :expired
  end

end
