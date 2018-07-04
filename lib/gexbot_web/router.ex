defmodule GexbotWeb.Router do
  use GexbotWeb, :router

  pipeline :public_api do
    plug :accepts, ["json"]
  end

  pipeline :authenticated_api do
    plug :accepts, ["json"]
  end

  scope "/api", GexbotWeb do
    pipe_through :authenticated_api
    resources "/installations", InstallationController, except: [:new, :edit, :create]
    resources "/authorizations", AuthorizationController, except: [:new, :edit]
    resources "/people", PersonController, except: [:new, :edit]

    post "/events", GithubHookController, :event
  end
end
