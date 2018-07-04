defmodule GexbotWeb.InstallationView do
  use GexbotWeb, :view
  alias GexbotWeb.InstallationView

  def render("index.json", %{installations: installations}) do
    %{data: render_many(installations, InstallationView, "installation.json")}
  end

  def render("show.json", %{installation: installation}) do
    %{data: render_one(installation, InstallationView, "installation.json")}
  end

  def render("installation.json", %{installation: installation}) do
    %{id: installation.id}
  end
end
