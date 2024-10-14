defmodule TimeManagerWeb.Auth do
  import Joken

  @doc """
  Génère un token JWT pour un utilisateur donné.
  """
  def token(user_id) do
    claims = %{user_id: user_id, exp: Joken.current_time() + 3600}

    Joken.token(claims)
    |> Joken.with_signer(signer())
    |> Joken.generate_and_sign()
  end

  defp signer() do
    # Remplacez par votre clé secrète
    secret_key = Application.get_env(:your_app_name, :secret_key)
    Joken.Signer.create("HS256", secret_key)
  end

  @doc """
  Vérifie et décode un token JWT.
  """
  def verify(token) do
    case Joken.decode_and_verify(token, signer()) do
      {:ok, claims} -> {:ok, claims}
      {:error, reason} -> {:error, reason}
    end
  end
end
