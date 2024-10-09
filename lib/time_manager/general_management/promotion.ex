defmodule TimeManager.GeneralManagement.Promotion do
  use Ecto.Schema
  import Ecto.Changeset

  schema "promotions" do
    field :promote, :boolean, default: false

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(promotion, attrs) do
    promotion
    |> cast(attrs, [:promote])
    |> validate_required([:promote])
  end
end
