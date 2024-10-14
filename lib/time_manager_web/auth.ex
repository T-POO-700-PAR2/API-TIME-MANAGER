defmodule TimeManagerWeb.Auth do
  alias TimeManager.Accounts.User
  alias Joken.Signer

  @signer Joken.Signer.create("HS256", Application.compile_env(:joken, :default_signer)[:key])

  def generate_jwt(%User{id: user_id}) do
    claims = %{sub: user_id}
    {:ok, token, _claims} = Joken.encode_and_sign(claims, @signer)
    token
  end

  def verify_jwt(token) do
    case Joken.verify_and_validate(@signer, token) do
      {:ok, claims} -> {:ok, claims}
      {:error, _reason} -> :error
    end
  end
end
