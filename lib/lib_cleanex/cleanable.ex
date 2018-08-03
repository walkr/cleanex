defprotocol Cleanex.Cleanable do
  @doc "Clean term"
  @fallback_to_any true
  def clean(_)
end

defimpl Cleanex.Cleanable, for: Map do
  def clean(map) do
    Enum.reduce(Map.keys(map), %{}, fn key, acc ->
      Map.put(acc, key, Map.fetch!(map, key) |> Cleanex.Cleanable.clean())
    end)
  end
end

defimpl Cleanex.Cleanable, for: List do
  alias Cleanex.Cleanable

  def clean(list) do
    list
    |> Enum.reduce([], fn val, acc -> [Cleanable.clean(val) | acc] end)
    |> :lists.reverse()
  end
end

defimpl Cleanex.Cleanable, for: Tuple do
  def clean(tuple) do
    tuple
    |> Tuple.to_list()
    |> Cleanex.clean()
    |> List.to_tuple()
  end
end

defimpl Cleanex.Cleanable, for: BitString do
  @doc """
  Collapse multiple spaces into just one, and trim the ends
  """
  def clean(string) do
    string

    # Get rid of null bytes
    |> String.replace("\0", "")

    # Replace 2+ spaces with single space
    |> (fn s -> Regex.replace(~r/\s{2,}/, s, " ") end).()

    # Trim ends
    |> String.trim()
  end
end

defimpl Cleanex.Cleanable, for: Atom do
  def clean(value), do: value
end

defimpl Cleanex.Cleanable, for: Integer do
  def clean(value), do: value
end

defimpl Cleanex.Cleanable, for: Float do
  def clean(value), do: value
end

defimpl Cleanex.Cleanable, for: PID do
  def clean(value), do: value
end

defimpl Cleanex.Cleanable, for: Port do
  def clean(value), do: value
end

defimpl Cleanex.Cleanable, for: Reference do
  def clean(value), do: value
end

defimpl Cleanex.Cleanable, for: Function do
  def clean(value), do: value
end

defimpl Cleanex.Cleanable, for: Any do
  def clean(term), do: term
end
