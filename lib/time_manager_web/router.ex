defmodule TimeManagerWeb.Router do
  use TimeManagerWeb, :router

  alias TimeManagerWeb.Plugs.AuthPlug

  # Define pipelines
  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :authenticated do
    plug AuthPlug
  end

  scope "/api", TimeManagerWeb do
    pipe_through :api

    post "/login", UserController, :login
    post "/logout", UserController, :logout
    resources "/users", UserController, except: [:new, :edit] # Open access for user creation and login
  end

  # Authenticated API routes (protected by JWT auth)
  scope "/api", TimeManagerWeb do
    pipe_through [:api, :authenticated] # Uses both the API and authentication pipelines

    # Only accessible if authenticated
    resources "/teams", TeamController, except: [:new, :edit]
    resources "/clocks", ClockController, except: [:new, :edit]
    resources "/working_times", WorkingTimeController, except: [:new, :edit]
    resources "/promotions", PromotionController, except: [:new, :edit]
  end
end
