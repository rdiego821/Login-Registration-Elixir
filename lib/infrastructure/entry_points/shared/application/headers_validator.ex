defmodule MsLoginRegistrationE.Infrastructure.EntryPoints.Shared.Application.HeadersValidator do
  @moduledoc """
  Headers validator
  """

  require Logger

  def validate_headers(%{
    message_id: message_id
  }) do
    with {:ok, true} <- validate_message_id(message_id) do
      {:ok, true}
    else
      error -> error
    end
  end

  def validate_headers(_any), do: {:error, :missing_headers_empty}

  def validate_body(body) do
    with {:ok, true} <- validate_map(body),
         {:ok, true} <- validate_field_data(body),
         {:ok, body} <- validate_data(body.data) do
      {:ok, body}
    else
      error ->
        Logger.error("Error validating body #{inspect(error)}")
        error
    end
  end

  defp validate_data(data) when is_map(data), do: {:ok, data}
  defp validate_data(_data), do: {:error, :missing_body_data}

  defp validate_field_data(data) do
    case Map.has_key?(data, :data) do
      true -> {:ok, true}
      false -> {:error, :invalid_field_data}
    end
  end

  defp validate_map(body) do
    case Enum.count(Map.to_list(body)) do
      1 -> {:ok, true}
      2 -> {:ok, true}
      0 -> {:error, :missing_body_map}
      _any -> {:error, :invalid_map_data}
    end
  end

  defp validate_message_id(message_id) when message_id != nil and byte_size(message_id) > 0 do
    message_id
    |> UUID.info()
    |> case do
         {:ok, _result} -> {:ok, true}
         {:error, _error} -> {:error, :invalid_message_id_data}
       end
  end

  defp validate_message_id(_message_id), do: {:error, :missing_headers_message_id}

end
