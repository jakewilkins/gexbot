defmodule GexbotWeb.PersonController do
  use GexbotWeb, :controller

  alias Gexbot.Auth
  alias Gexbot.Auth.Person

  action_fallback GexbotWeb.FallbackController

  def index(conn, _params) do
    people = Auth.list_people()
    render(conn, "index.json", people: people)
  end

  def create(conn, %{"person" => person_params}) do
    with {:ok, %Person{} = person} <- Auth.create_person(person_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", person_path(conn, :show, person))
      |> render("show.json", person: person)
    end
  end

  def show(conn, %{"id" => id}) do
    person = Auth.get_person!(id)
    render(conn, "show.json", person: person)
  end

  def update(conn, %{"id" => id, "person" => person_params}) do
    person = Auth.get_person!(id)

    with {:ok, %Person{} = person} <- Auth.update_person(person, person_params) do
      render(conn, "show.json", person: person)
    end
  end

  def delete(conn, %{"id" => id}) do
    person = Auth.get_person!(id)
    with {:ok, %Person{}} <- Auth.delete_person(person) do
      send_resp(conn, :no_content, "")
    end
  end
end
