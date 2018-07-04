defmodule Gexbot.Github.Events do
  use GenServer

  alias Gexbot.Github.Event
  alias Gexbot.Auth

  @name __MODULE__

  def start_link() do
    GenServer.start_link(@name, [], name: @name)
  end

  def init(_) do
    {:ok, %{}}
  end

  def webhook(event, map) when is_map(map) do
    Event.from(event, map)
    |> webhook
  end

  def webhook(%Event{} = event) do
    GenServer.cast(@name, event)
  end

  def handle_cast(%Event{event: "integration_installation", type: "created"} = event, state) do
    Auth.create_installation(event)
    {:noreply, state}
  end

  def handle_cast(%Event{} = event, state) do
    IO.puts "here!!"
    IO.inspect event
    IO.puts "here!!"

    {:noreply, state}
  end

end
