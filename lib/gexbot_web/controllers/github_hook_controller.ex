defmodule GexbotWeb.GithubHookController do
  use GexbotWeb, :controller

  alias Gexbot.Auth
  alias Gexbot.Auth.Installation

  action_fallback GexbotWeb.FallbackController

  def event(conn, params) do
    {_, event} = conn.req_headers |> Enum.find(fn
                   {"x-github-event", _} -> true
                   {header_name, value} -> false
                 end)

    Gexbot.Github.Events.webhook(event, params)

    send_resp(conn, :no_content, "")
  end
end
