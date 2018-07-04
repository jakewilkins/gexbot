defmodule GexbotWeb.AuthorizationView do
  use GexbotWeb, :view
  alias GexbotWeb.AuthorizationView

  def render("index.json", %{authorizations: authorizations}) do
    %{data: render_many(authorizations, AuthorizationView, "authorization.json")}
  end

  def render("show.json", %{authorization: authorization}) do
    %{data: render_one(authorization, AuthorizationView, "authorization.json")}
  end

  def render("authorization.json", %{authorization: authorization}) do
    %{id: authorization.id}
  end
end
