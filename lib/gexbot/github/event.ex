defmodule Gexbot.Github.Event do
  defstruct [event: nil, type: nil, data: nil]

  def from(event, data) do
    type = Map.get(data, "action")
    %__MODULE__{event: event, type: type, data: data}
  end
end
