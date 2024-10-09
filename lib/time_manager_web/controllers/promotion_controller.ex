defmodule TimeManagerWeb.PromotionController do
  use TimeManagerWeb, :controller

  alias TimeManager.GeneralManager
  alias TimeManager.GeneralManager.Promotion

  action_fallback TimeManagerWeb.FallbackController

  def index(conn, _params) do
    promotions = GeneralManager.list_promotions()
    render(conn, :index, promotions: promotions)
  end

  def create(conn, %{"promotion" => promotion_params}) do
    with {:ok, %Promotion{} = promotion} <- GeneralManager.create_promotion(promotion_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/promotions/#{promotion}")
      |> render(:show, promotion: promotion)
    end
  end

  def show(conn, %{"id" => id}) do
    promotion = GeneralManager.get_promotion!(id)
    render(conn, :show, promotion: promotion)
  end

  def update(conn, %{"id" => id, "promotion" => promotion_params}) do
    promotion = GeneralManager.get_promotion!(id)

    with {:ok, %Promotion{} = promotion} <- GeneralManager.update_promotion(promotion, promotion_params) do
      render(conn, :show, promotion: promotion)
    end
  end

  def delete(conn, %{"id" => id}) do
    promotion = GeneralManager.get_promotion!(id)

    with {:ok, %Promotion{}} <- GeneralManager.delete_promotion(promotion) do
      send_resp(conn, :no_content, "")
    end
  end
end
