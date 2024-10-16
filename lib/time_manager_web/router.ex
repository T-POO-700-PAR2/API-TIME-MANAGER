defmodule TimeManagerWeb.Router do
  use TimeManagerWeb, :router

  import TimeManagerWeb.Plugs.EnsureRolePlug

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :manager do
    plug :ensure_manager_role
  end

  pipeline :general_manager do
    plug :ensure_general_manager_role
  end

  scope "/api", TimeManagerWeb do
    pipe_through :api

    resources "/users", UserController, except: [:new, :edit]
    resources "/teams", TeamController, except: [:new, :edit]
    resources "/clocks", ClockController, except: [:new, :edit]
    resources "/working_times", WorkingTimeController, except: [:new, :edit]
    resources "/promotions", PromotionController, except: [:new, :edit]
  end

  scope "/api", TimeManagerWeb do
    pipe_through [:api, :manager]

    post "/teams/:team_id/add_user", TeamController, :add_user
    delete "/teams/:team_id/remove_user/:user_id", TeamController, :remove_user
  end

  scope "/api", TimeManagerWeb do
    pipe_through [:api, :general_manager]

  end
end
