defprotocol Cleanex.Cleanable do
  @doc "Clean terms"
  @fallback_to_any true
  def clean(_)
end

defimpl Cleanex.Cleanable, for: Any do
  def clean(term), do: term
end

defimpl Cleanex.Cleanable, for: Map do
  def clean(map) do
    Enum.reduce(Map.keys(map), %{}, fn key, acc ->
      Map.put(acc, key, Map.fetch!(map, key) |> Cleanex.Cleanable.clean())
    end)
  end
end

defimpl Cleanex.Cleanable, for: List do
  def clean(list) do
    Enum.reduce(list, [], fn
      # Tuple
      {key, val}, acc ->
        [{key, Cleanex.Cleanable.clean(val)} | acc]

      # Other term
      val, acc ->
        [Cleanex.Cleanable.clean(val) | acc]
    end)
    |> :lists.reverse()
  end
end

defimpl Cleanex.Cleanable, for: BitString do
  @doc """
  Collapse multiple spaces into just one, and trim the ends
  """
  def clean(string) do
    # Replace double+ spaces
    Regex.replace(~r/\s{2,}/, string, " ")

    # Trim ends
    |> String.trim()

    # Get rid of null bytes
    |> String.replace("\0", "")
  end
end
